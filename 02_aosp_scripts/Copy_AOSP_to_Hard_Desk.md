# 📘 Tutorial: Copy Folders to External HDD with Progress and Safe Eject (Ubuntu)

This tutorial explains how to **mount an external HDD**, **copy multiple folders with progress**, and then **safely eject the drive**.  
Each step includes commands and explanations of the flags, symbols, and variables used.

---

## 🟢 STEP 1: Detect External HDD

First, check if your external HDD mount directory exists.

```bash
MOUNTPOINT="/media/$USER/Mourad1"
```
- `MOUNTPOINT="..."` → defines a variable that stores the mount location.
- `$USER` → built-in variable containing your current username (e.g., `mourad`).
- `/media/$USER/Mourad1` → typical location where USB drives and external disks are mounted.

---

### 1.1 Create mount directory if it doesn’t exist

```bash
if [ ! -d "$MOUNTPOINT" ]; then
    sudo mkdir -p "$MOUNTPOINT"
else
    echo "-> Mount directory already exists: $MOUNTPOINT"
fi
```

- `[ ]` → Bash test command.
- `-d` → true if a directory exists.
- `!` → negation (NOT).
- `"$MOUNTPOINT"` → expands to the value of the variable.
- `mkdir -p` → create directory (no error if it already exists).
- `sudo` → run as root (required for system folders).

---

### 1.2 Mount the drive if not mounted

``` bash
if mount | grep -q "$MOUNTPOINT"; then
    echo "-> External HDD is already mounted at $MOUNTPOINT"
else
    sudo mount /dev/sda1 "$MOUNTPOINT"
fi
```

- `mount` → lists mounted filesystems.
- `grep -q` → quiet search, no output, just success/failure.
- `/dev/sda1` → first partition of external drive.

---

## 🟢 STEP 2: Verify Mount
Check if the drive is mounted correctly:

``` bash
df -h | grep "$MOUNTPOINT"
```

- `df -h` → shows disk usage in human-readable format (sizes like `10M`, `1G`).
- `grep "$MOUNTPOINT"` → filters only lines containing your mount point.

---

## 🟢 STEP 3: Copy Folders with Progress
We use `rsync` to copy data:
```bash
rsync -avh --progress \
    ~/WORKSPACE/Folder1/ \
    ~/WORKSPACE/Folder2/ \
    ~/WORKSPACE/Folder3/ \
    "$MOUNTPOINT/"
```

### Flags:
- `-a` → archive mode (preserves symlinks, permissions, timestamps).
- `-v` → verbose (prints what’s being copied).
- `-h` → human-readable (shows `10M` instead of `10485760`).
- `--progress` → shows progress bar and percentage per file.

### Paths:
- `~` → shortcut for your home directory (`/home/mourad`).
- `Folder1`/ (with `/`) → copy ***`contents of the folder`***, **`not`** the ***`folder itself`***.
- Without `/` → the ***`folder itself`*** will be copied into the destination.

---

## 🟢 STEP 4: Confirm Copy Completed
You should see:

``` python
sent XXX bytes  received XXX bytes  total size is XXX
```
This confirms data was transferred.

---

## 🟢 STEP 5: Safe Eject of External HDD
Before unplugging, unmount and power off safely.

### 5.1 Make sure you’re not inside the mount folder

``` bash
if [[ $PWD == $MOUNTPOINT* ]]; then
    cd ~
fi
```
- `$PWD` → built-in variable with your present working directory.
- `[[ $PWD == $MOUNTPOINT* ]]` → checks if current folder path starts with `$MOUNTPOINT`.
- `*` → wildcard (any characters after).
- `cd ~` → move back to home directory.

---

### 5.2 Check if any process is still using the disk
``` bash
lsof +f -- "$MOUNTPOINT"
```
- `lsof` → list open files (shows which processes are using the mount).
- `+f --` → restricts search to the filesystem.

---

### 5.3 Unmount the partition
``` bash
udisksctl unmount -b /dev/sda1
```
- udisksctl → tool to manage disks.
- unmount -b /dev/sda1 → unmounts the partition `/dev/sda1`.

---

### 5.4 Power off the whole drive
``` bash 
udisksctl power-off -b /dev/sda
```
- `power-off` → tells the drive to spin down / cut power (like Windows eject).

Now it is **safe to unplug your external HDD**.

---

## ✅ Summary

1. Create/check mount directory.
2. M0ount /dev/sda1 to it.
3. Verify with df -h.
4. Copy folders with rsync -avh --progress.
5. Unmount and power off safely with udisksctl.

That’s it! 🎉 We now have a **step-by-step manual process** for safe copying and ejecting in Ubuntu.