#!/bin/bash
# Shebang


# =======================================================================================
# Copy Folder and It's content to somewhere else safely, with progress shown in terminal.
# =======================================================================================


######################################
# ✅ 1. Using rsync (best & safest)
######################################
# Copy a whole folder (with subfolders + files).
# Keep permissions, symlinks, timestamps (no data loss).
# See progress in the terminal.
# Here are the safe options 👇
# rsync -a --info=progress2 AOSP/ ~/WORKSPACE/AOSP_15.0.0_36/
rsync -avh --progress AOSP/ ~/WORKSPACE/AOSP_15.0.0_36/
# Explanation:
# -a → archive mode (preserves permissions, ownership, symlinks, timestamps).
# -v → verbose (shows details).
# -h → human-readable file sizes.
# --progress → shows live progress for each file.
# Trailing / after source means copy contents (not the folder itself).
##################
# 🔹 Recommended#
##################
# Use rsync — it’s the most reliable and widely used for backups, mirroring, and safe copies.
#
#############################################
# SAFE COPY WITH RSYNC (supports resume)
#
# Usage:
#   rsync -avh --progress /path/to/source/ /path/to/destination/
#
# Options:
#   -a           : archive mode (preserves permissions, symlinks, timestamps, etc.)
#   -v           : verbose output
#   -h           : human-readable sizes
#   --progress   : show real-time copy progress
#
# Resume options:
#   --partial        : keep partially copied files so rsync can resume them
#   --append-verify  : resume from last byte + verify integrity (safer)
#
# Examples:
#   # Normal safe copy with progress
#   rsync -avh --progress ~/android_aosp/ /mnt/backup/android_aosp/
#
#   # Resume interrupted copy
#   rsync -avh --append-verify --progress ~/android_aosp/ /mnt/backup/android_aosp/
#
#   # Dry run (check what would be copied without doing it)
#   rsync -avhn ~/android_aosp/ /mnt/backup/android_aosp/
#
# Why rsync?
# - Unlike cp, it resumes interrupted transfers.
# - Verifies data integrity.
# - Used in production, backups, and AOSP syncing.
#############################################




#######################################
# ✅ 2. Using cp with progress (via pv)
#######################################
# If you don’t have rsync, you can use cp + pv:
# $ tar cf - /path/to/source | pv | tar xf - -C /path/to/destination
# tar cf - → packs the folder into a stream.
# pv → shows progress while streaming.
# tar xf - → extracts into the destination.


##########################################
# ✅ 3. Using cp (basic, but no progress)
##########################################
# $ cp -a /path/to/source /path/to/destination
# -a (archive) keeps everything intact.
# Downside → no progress output.

####################################
# ❌ 4. Avoid using scp or simple cp for large copies (not recommended)
####################################



################################################################################################################
# dd 🙌 — it’s powerful, but a bit different from rsync or cp.
################################################################################################################
#
# 🔹 What dd is for
#     -   dd works at the block/device level, not at the file/folder level.
#     -   It’s great for cloning entire disks, partitions, or raw images (like .img files, SD cards, or ISO burning).
#     -   It’s not meant for copying directories safely with permissions & symlinks like rsync does.
#
# ✅ Example: Copy a whole disk with progress
# $ sudo dd if=/dev/sdX of=/dev/sdY bs=4M status=progress
#   if= → input file (e.g., disk, partition, or image).
#   of= → output file.
#   bs=4M → block size (faster copy).
#   status=progress → shows progress while copying.
#
# 👉 Example (make a backup image of a USB drive):
# $ sudo dd if=/dev/sdb of=~/usb_backup.img bs=4M status=progress
#
# 👉 Restore it later:
# $ sudo dd if=~/usb_backup.img of=/dev/sdb bs=4M status=progress
#
# ⚠️ Why not use dd for folders?
#       -   dd doesn’t understand files, permissions, symlinks, dependencies.
#       -   If you run dd on a directory path, it will fail (dd expects a block device or file, not a folder).
#       -   It only works at the raw data level (disks, partitions, single files).
#
# 🔹 Summary
#       -   Use rsync or cp -a → for folders with subfolders, safe copy, preserving metadata.
#       -   Use dd → for cloning disks/partitions/images, not directories.
#
# ❗ Important: Be very careful with dd!
#   -   A small mistake in if= or of= can lead to data loss.
#   -   Always double-check the device names (e.g., /dev/sdX).
#   -   Use lsblk or fdisk -l to identify disks/partitions before using dd.
#   -   dd is powerful but unforgiving — it will overwrite data without warning.
#   -   For copying folders safely, stick to rsync or cp.
#   -   Use dd only when you need to clone disks/partitions or create raw backups.