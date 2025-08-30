#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# Create a permanent 40 GiB swapfile on Ubuntu (with safety checks).
#
# What this script does:
#  - Verifies free disk space and escalates to root if needed.
#  - Creates /swapfile with correct permissions (handles btrfs safely).
#  - Formats it as swap and enables it immediately.
#  - Adds an entry to /etc/fstab so it persists after reboot.
#  - Optionally adjusts vm.swappiness.
#
# Safe defaults:
#  - Backs up /etc/fstab.
#  - Won't overwrite existing /swapfile unless FORCE_RECREATE=true.
# -----------------------------------------------------------------------------

set -euo pipefail
IFS=$'\n\t'

# ------------------------- Configuration section ------------------------------
SWAPFILE="/swapfile"     # Path of the swap file to create.
SIZE_GB=40               # Desired swap size in GiB (40 GiB as requested).
SWAPPINESS=10            # Optional: lower = prefer RAM more; Ubuntu default is 60.
FORCE_RECREATE=false     # Set to true to replace an existing $SWAPFILE if found.
# -----------------------------------------------------------------------------

log()  { printf '[*] %s\n' "$*"; }
warn() { printf '[!] %s\n' "$*" >&2; }
die()  { printf '[x] %s\n' "$*" >&2; exit 1; }

# Ensure we are root; if not, re-exec under sudo and keep relevant env vars.
if [[ $EUID -ne 0 ]]; then
  exec sudo --preserve-env=SWAPFILE,SIZE_GB,SWAPPINESS,FORCE_RECREATE bash "$0" "$@"
fi

# Check there is enough free space where the swap file will live.
# - df --output=avail -B1 <path> : free bytes available on the filesystem.
REQ_BYTES=$(( SIZE_GB * 1024 * 1024 * 1024 ))
MOUNT_DIR="$(dirname -- "$SWAPFILE")"
AVAIL_BYTES=$(df --output=avail -B1 "$MOUNT_DIR" | tail -1 | tr -d '[:space:]')
(( AVAIL_BYTES >= REQ_BYTES )) || die "Not enough free space on $MOUNT_DIR (need ~${SIZE_GB}GiB)."

# Backup /etc/fstab before we change it.
TS=$(date +%Y%m%d-%H%M%S)
cp -a /etc/fstab "/etc/fstab.backup.${TS}"
log "Backed up /etc/fstab -> /etc/fstab.backup.${TS}"

# If a swapfile already exists, decide what to do.
if [[ -e "$SWAPFILE" ]]; then
  if [[ "$FORCE_RECREATE" == true ]]; then
    log "$SWAPFILE exists; FORCE_RECREATE=true, removing it safely."
    # swapoff: disable swap for the file if currently active (ignore error if not active).
    swapoff "$SWAPFILE" || true
    rm -f "$SWAPFILE"
    # Remove any existing fstab line matching "<SWAPFILE>  none  swap ..."
    # sed -i: edit in place. The pattern uses '#' as delimiter to avoid escaping '/'.
    sed -i "\#^$SWAPFILE[[:space:]]\+none[[:space:]]\+swap#d" /etc/fstab
  else
    die "$SWAPFILE already exists. Re-run with FORCE_RECREATE=true to replace it."
  fi
fi

# Detect filesystem type of the directory that will hold the swap file.
# - findmnt -n: no headings. -o FSTYPE: show only fs type. --target <path>: lookup by path.
FSTYPE=$(findmnt -n -o FSTYPE --target "$MOUNT_DIR" || echo "unknown")
log "Filesystem for $MOUNT_DIR is '$FSTYPE'"

# Create the swap file:
# Permissions MUST be 600 (owner read/write only) for security; the kernel enforces this.
if [[ "$FSTYPE" == "btrfs" ]]; then
  # Special handling for btrfs:
  # - btrfs uses Copy-on-Write (CoW) by default; swapfiles must be NOCOW (+C).
  # - We avoid 'fallocate' here; 'dd' writes real blocks and works reliably with +C.
  log "btrfs detected: creating swapfile with NOCOW and allocating via 'dd' (no reflinks)."
  # install -m 600: create an empty file with mode 600 in one step.
  install -m 600 /dev/null "$SWAPFILE"
  # chattr +C: disable CoW (NOCOW attribute). If chattr isn't available, continue anyway.
  chattr +C "$SWAPFILE" 2>/dev/null || warn "Could not set NOCOW (+C). Proceeding."
  # dd: copy zeros into the file to the requested size.
  #   if=/dev/zero : read zeros
  #   of=$SWAPFILE : write to swapfile
  #   bs=1M        : block size 1 MiB
  #   count=X      : number of blocks to write (SIZE_GB * 1024)
  #   status=progress : show live progress
  dd if=/dev/zero of="$SWAPFILE" bs=1M count=$(( SIZE_GB * 1024 )) status=progress
else
  # On non-btrfs (e.g., ext4/xfs), 'fallocate' is fast and efficient.
  # fallocate -l <size> <file> :
  #   -l : length (accepts K, M, G suffixes; here 40G = 40 * 1024^3 bytes)
  log "Allocating $SIZE_GB GiB with fallocate at $SWAPFILE"
  fallocate -l "${SIZE_GB}G" "$SWAPFILE"
  chmod 600 "$SWAPFILE"
fi

# Ensure final permissions are correct (in case of the dd path).
chmod 600 "$SWAPFILE"

# mkswap <file> :
#   Initializes the file with a swap area signature so the kernel can use it as swap.
mkswap "$SWAPFILE"

# swapon <file> :
#   Activates the swap area immediately (no reboot required).
swapon "$SWAPFILE"

# Make it persist across reboots by adding a line to /etc/fstab:
# fstab fields:
#   <spec>    <file>  <vfs> <options> <dump> <pass>
#   /swapfile  none    swap   sw        0      0
if ! grep -qE "^$SWAPFILE[[:space:]]+none[[:space:]]+swap" /etc/fstab; then
  printf "%s\t%s\t%s\t%s\t%s\t%s\n" "$SWAPFILE" "none" "swap" "sw" "0" "0" >> /etc/fstab
  log "Added $SWAPFILE to /etc/fstab for persistence."
else
  log "$SWAPFILE is already present in /etc/fstab."
fi

# Optional tuning: set vm.swappiness to prefer RAM and reduce swapping aggressiveness.
# sysctl -w key=value : write a kernel parameter at runtime (takes effect immediately).
sysctl -w vm.swappiness="$SWAPPINESS" >/dev/null
# Persist swappiness across reboots:
if ! grep -q "^vm.swappiness" /etc/sysctl.conf; then
  echo "vm.swappiness=$SWAPPINESS" >> /etc/sysctl.conf
else
  sed -i "s/^vm.swappiness=.*/vm.swappiness=$SWAPPINESS/" /etc/sysctl.conf
fi
log "Set vm.swappiness=$SWAPPINESS (lower = less aggressive swapping)."

# Show final status for verification.
log "Final swap status:"
# swapon --show : list active swap areas.
swapon --show
# free -h : human-readable RAM/swap usage snapshot.
free -h

  273  source build/envsetup.sh
  274  ls
  275  cd
  276  cd ~/WORKSPACE/AOSP_15.0.0_36/
  277  source build/envsetup.sh
  278  lunch aosp_cf_x86_64_auto-trunk_staging-userdebug
  279  source build/envsetup.sh
  280  lunch aosp_cf_x86_64_auto-trunk_staging-userdebug
  281  repo sync -j$(nproc)
  282  hmm
  283  m
  284  histo
log "All done. To undo later: 'swapoff $SWAPFILE && rm $SWAPFILE' and remove its line from /etc/fstab."
log "Backup kept at: /etc/fstab.backup.${TS}"
#############################################
# Basic File/Folder Operations in Linux
#############################################

# 1. Create a file
touch filename.txt         # 'touch' creates an empty file named 'filename.txt' if it doesn't exist, or updates the timestamp if it does.

# 2. Create a directory (folder)
mkdir myfolder             # 'mkdir' creates a directory named 'myfolder' in the current location.
mkdir -p parent/child      # '-p' tells 'mkdir' to create parent directories as needed (creates 'parent' and 'child' inside it).

# 3. Copy files and folders
cp file1.txt file2.txt     # 'cp' copies 'file1.txt' to 'file2.txt'. If 'file2.txt' exists, it will be overwritten.
cp file.txt dir/           # Copies 'file.txt' into the directory 'dir/'. The trailing slash is optional but recommended for clarity.
cp -r dir1/ dir2/          # '-r' (recursive) copies the directory 'dir1' and all its contents (files and subfolders) into 'dir2'.

#### Example of copying folder contents to another location
cp -r AOSP ~/WORKSPACE/AOSP_15.0.0_36/
# 'cp' = copy command
# '-r' = recursive, needed for directories
# 'AOSP' = source folder
# '~/WORKSPACE/AOSP_15.0.0_36/' = destination directory (the '~' means your home directory)

#### Example with progress using rsync
rsync -a --info=progress2 AOSP/ ~/WORKSPACE/AOSP_15.0.0_36/
# 'rsync' = advanced copy/sync tool
# '-a' = archive mode (preserves permissions, timestamps, etc.)
# '--info=progress2' = shows overall progress and percentage
# 'AOSP/' = source folder (trailing slash means copy contents)
# '~/WORKSPACE/AOSP_15.0.0_36/' = destination directory

# 4. Move (or rename) files and folders
mv oldname.txt newname.txt    # 'mv' renames 'oldname.txt' to 'newname.txt'.
mv file.txt dir/              # Moves 'file.txt' into the directory 'dir/'.
mv dir1/ dir2/                # Moves or renames 'dir1' to 'dir2'. If 'dir2' exists, 'dir1' is moved inside it.

# 5. Delete files and folders
rm file.txt               # 'rm' removes (deletes) the file 'file.txt'.
rm -f file.txt            # '-f' (force) deletes without asking for confirmation, even if the file is write-protected.
rm -r dir/                # '-r' (recursive) deletes the directory 'dir/' and all its contents.
rm -rf dir/               # '-rf' combines recursive and force: deletes directory and contents without any prompts.

# 6. Search for files and folders
find . -name "*.txt"      # 'find' searches from current directory ('.') for files ending with '.txt'.
find /path -type d -name "myfolder"   # Searches in '/path' for directories ('-type d') named 'myfolder'.

# 7. List and sort files/folders
ls                        # 'ls' lists files and directories in the current directory.
ls -l                     # '-l' (long) shows details like permissions, owner, size, and date.
ls -lh                    # '-h' (human-readable) shows sizes in KB/MB/GB (use with '-l').
ls -lt                    # '-t' sorts by modification time (newest first, use with '-l').
ls -lS                    # '-S' sorts by file size (largest first, use with '-l').

# 8. View file contents
cat file.txt              # 'cat' prints the entire contents of 'file.txt' to the terminal.
less file.txt             # 'less' lets you scroll through 'file.txt' page by page (use 'q' to quit).
head file.txt             # 'head' shows the first 10 lines of 'file.txt'.
tail file.txt             # 'tail' shows the last 10 lines of 'file.txt'.

# 9. Other useful operations
du -sh dir/               # 'du' (disk usage), '-s' (summary), '-h' (human-readable): shows total size of 'dir/'.
df -h                     # 'df' (disk free), '-h' (human-readable): shows available disk space on all mounted filesystems.

#############################################
# Aliases and Shortcuts
#############################################

# Temporary alias (only for current terminal session)
alias ll='ls -l --color=auto'        # 'alias' creates a shortcut: 'll' will run 'ls -l --color=auto' (detailed, colored list).

# To remove a temporary alias in the session:
unalias ll                           # 'unalias' removes the alias 'll' for the current session.

# Permanent alias (always available)
# 1. Open your shell config file (e.g., ~/.bashrc or ~/.zshrc)
# 2. Add your alias, e.g.:
#    alias ll='ls -l --color=auto'
# 3. Save the file and reload config:
#    source ~/.bashrc                # 'source' reloads the config so new aliases work immediately.

# Example permanent aliases:
# alias rm='rm -i'                   # '-i' (interactive): always ask before deleting.
# alias cp='cp -i'                   # Always ask before overwriting files when copying.
# alias mv='mv -i'                   # Always ask before overwriting files when moving.

#############################################
# Notes
#############################################
# - Use 'man <command>' for more details (e.g., man cp)
# - Use wildcards (*, ?) for pattern matching in file names
# - Always be careful with 'rm -rf' as it deletes without recovery

# End of summary#############################################
# Basic File/Folder Operations in Linux
#############################################

# 1. Create a file
touch filename.txt         # 'touch' creates an empty file named 'filename.txt' if it doesn't exist, or updates the timestamp if it does.

# 2. Create a directory (folder)
mkdir myfolder             # 'mkdir' creates a directory named 'myfolder' in the current location.
mkdir -p parent/child      # '-p' tells 'mkdir' to create parent directories as needed (creates 'parent' and 'child' inside it).

# 3. Copy files and folders
cp file1.txt file2.txt     # 'cp' copies 'file1.txt' to 'file2.txt'. If 'file2.txt' exists, it will be overwritten.
cp file.txt dir/           # Copies 'file.txt' into the directory 'dir/'. The trailing slash is optional but recommended for clarity.
cp -r dir1/ dir2/          # '-r' (recursive) copies the directory 'dir1' and all its contents (files and subfolders) into 'dir2'.

#### Example of copying folder contents to another location
cp -r AOSP ~/WORKSPACE/AOSP_15.0.0_36/
# 'cp' = copy command
# '-r' = recursive, needed for directories
# 'AOSP' = source folder
# '~/WORKSPACE/AOSP_15.0.0_36/' = destination directory (the '~' means your home directory)

#### Example with progress using rsync
rsync -a --info=progress2 AOSP/ ~/WORKSPACE/AOSP_15.0.0_36/
# 'rsync' = advanced copy/sync tool
# '-a' = archive mode (preserves permissions, timestamps, etc.)
# '--info=progress2' = shows overall progress and percentage
# 'AOSP/' = source folder (trailing slash means copy contents)
# '~/WORKSPACE/AOSP_15.0.0_36/' = destination directory

# 4. Move (or rename) files and folders
mv oldname.txt newname.txt    # 'mv' renames 'oldname.txt' to 'newname.txt'.
mv file.txt dir/              # Moves 'file.txt' into the directory 'dir/'.
mv dir1/ dir2/                # Moves or renames 'dir1' to 'dir2'. If 'dir2' exists, 'dir1' is moved inside it.

# 5. Delete files and folders
rm file.txt               # 'rm' removes (deletes) the file 'file.txt'.
rm -f file.txt            # '-f' (force) deletes without asking for confirmation, even if the file is write-protected.
rm -r dir/                # '-r' (recursive) deletes the directory 'dir/' and all its contents.
rm -rf dir/               # '-rf' combines recursive and force: deletes directory and contents without any prompts.

# 6. Search for files and folders
find . -name "*.txt"      # 'find' searches from current directory ('.') for files ending with '.txt'.
find /path -type d -name "myfolder"   # Searches in '/path' for directories ('-type d') named 'myfolder'.

# 7. List and sort files/folders
ls                        # 'ls' lists files and directories in the current directory.
ls -l                     # '-l' (long) shows details like permissions, owner, size, and date.
ls -lh                    # '-h' (human-readable) shows sizes in KB/MB/GB (use with '-l').
ls -lt                    # '-t' sorts by modification time (newest first, use with '-l').
ls -lS                    # '-S' sorts by file size (largest first, use with '-l').

# 8. View file contents
cat file.txt              # 'cat' prints the entire contents of 'file.txt' to the terminal.
less file.txt             # 'less' lets you scroll through 'file.txt' page by page (use 'q' to quit).
head file.txt             # 'head' shows the first 10 lines of 'file.txt'.
tail file.txt             # 'tail' shows the last 10 lines of 'file.txt'.

# 9. Other useful operations
du -sh dir/               # 'du' (disk usage), '-s' (summary), '-h' (human-readable): shows total size of 'dir/'.
df -h                     # 'df' (disk free), '-h' (human-readable): shows available disk space on all mounted filesystems.

#############################################
# Aliases and Shortcuts
#############################################

# Temporary alias (only for current terminal session)
alias ll='ls -l --color=auto'        # 'alias' creates a shortcut: 'll' will run 'ls -l --color=auto' (detailed, colored list).

# To remove a temporary alias in the session:
unalias ll                           # 'unalias' removes the alias 'll' for the current session.

# Permanent alias (always available)
# 1. Open your shell config file (e.g., ~/.bashrc or ~/.zshrc)
# 2. Add your alias, e.g.:
#    alias ll='ls -l --color=auto'
# 3. Save the file and reload config:
#    source ~/.bashrc                # 'source' reloads the config so new aliases work immediately.

# Example permanent aliases:
# alias rm='rm -i'                   # '-i' (interactive): always ask before deleting.
# alias cp='cp -i'                   # Always ask before overwriting files when copying.
# alias mv='mv -i'                   # Always ask before overwriting files when moving.

#############################################
# Notes
#############################################
# - Use 'man <command>' for more details (e.g., man cp)
# - Use wildcards (*, ?) for pattern matching in file names
# - Always be careful with 'rm -rf' as it deletes without recovery

# End of summary