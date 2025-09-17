#!/bin/bash
# =====================================================================
# Script: copy_to_external.sh
# Purpose: Mount external HDD, copy folders with progress, then safely eject
# Author: Mourad
# =====================================================================

# ---------- [STEP 1] Detect External HDD ----------
echo "====================================================================="
echo "[STEP 1] Checking if external HDD (/dev/sda1) is already mounted..."
echo "====================================================================="

# Variables in bash are written as NAME=value
# $USER  → built-in variable, holds your current username
# $MOUNTPOINT → our custom variable to store the folder where we mount the HDD
MOUNTPOINT="/media/$USER/Mourad1"

# The test [ ! -d "$MOUNTPOINT" ] checks if directory does NOT exist:
# [ ]     → bash test command
# -d      → true if directory exists
# !       → negation (NOT operator)
# "$MOUNTPOINT" → expands to the string value of variable MOUNTPOINT
if [ ! -d "$MOUNTPOINT" ]; then
    echo "-> Mount directory not found, creating: $MOUNTPOINT"
    # mkdir = make directory
    # -p = create parent directories if needed (no error if it already exists)
    sudo mkdir -p "$MOUNTPOINT"
else
    echo "-> Mount directory already exists: $MOUNTPOINT"
fi

# The 'mount' command shows all mounted filesystems.
# 'grep -q' searches quietly (no output, just exit code).
# This checks if our mountpoint is already mounted.
if mount | grep -q "$MOUNTPOINT"; then
    echo "-> External HDD is already mounted at $MOUNTPOINT"
else
    echo "-> Mounting /dev/sda1 to $MOUNTPOINT ..."
    # sudo = run as superuser (root), needed for mounting
    # mount /dev/sda1 $MOUNTPOINT  → mounts device partition to directory
    sudo mount /dev/sda1 "$MOUNTPOINT"
    echo "-> Mount completed."
fi

# ---------- [STEP 2] Verify Mount ----------
echo
echo "====================================================================="
echo "[STEP 2] Verifying the mount..."
echo "====================================================================="

# df -h → shows disk free space in human-readable format (h = human-readable)
# grep "$MOUNTPOINT" → filter only lines containing the mountpoint
df -h | grep "$MOUNTPOINT"

# ---------- [STEP 3] Copy Folders ----------
echo
echo "====================================================================="
echo "[STEP 3] Copying folders using rsync"
echo "====================================================================="

# rsync = robust file copy tool
# Flags:
# -a : archive mode (preserves permissions, symbolic links, timestamps, etc.)
# -v : verbose (prints what files are being copied)
# -h : human-readable (prints sizes as 10M, 1G instead of bytes)
# --progress : shows progress bar and percentage for each file
# Sources: list of folders we want to copy (can be more than one)
# Destination: must be the last argument

rsync -avh --progress \
    ~/WORKSPACE/Folder1/ \
    ~/WORKSPACE/Folder2/ \
    ~/WORKSPACE/Folder3/ \
    "$MOUNTPOINT/"

# Note:
# ~ (tilde) = shortcut for your home directory (/home/username)
# Trailing slash (Folder1/) means "copy contents of folder" not the folder itself.

echo
echo "====================================================================="
echo "[STEP 4] Copy Completed!"
echo "====================================================================="

# ---------- [STEP 5] Safe Eject ----------
echo
echo "====================================================================="
echo "[STEP 5] Safe Eject of External HDD"
echo "====================================================================="

# $PWD  → built-in variable that holds "present working directory" (current folder path)
# [[ $PWD == $MOUNTPOINT* ]] → checks if current path starts with $MOUNTPOINT
# * = wildcard (any characters after)
if [[ $PWD == $MOUNTPOINT* ]]; then
    echo "-> You are inside $MOUNTPOINT, moving to home directory..."
    cd ~    # cd = change directory, ~ = go to home
fi

# lsof = list open files (shows which processes are using a filesystem)
# +f -- $MOUNTPOINT = restrict to that filesystem only
echo "-> Checking if any process is using $MOUNTPOINT..."
lsof +f -- "$MOUNTPOINT"

# udisksctl = command-line tool to manage disks safely
# unmount -b /dev/sda1 → unmounts the partition
echo "-> Unmounting /dev/sda1 ..."
udisksctl unmount -b /dev/sda1

# power-off -b /dev/sda → powers off the entire drive (safe remove)
echo "-> Powering off /dev/sda ..."
udisksctl power-off -b /dev/sda

echo
echo "====================================================================="
echo "[ALL DONE] External HDD safely ejected!"
echo "====================================================================="