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

# End of summary