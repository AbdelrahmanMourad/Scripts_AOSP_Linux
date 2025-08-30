#!/bin/bash
# The shebang (#!) at the top tells the system to use the Bash shell to interpret this script.
# It ensures your script runs with the correct shell, regardless of the user's default shell.
# This is important for compatibility and to avoid unexpected behavior if the script uses Bash-specific features.
# Always place the shebang as the very first line in your script.


#############################################
# How to Cancel (Remove) the Already Allocated Swap RAM
#############################################

# 1. Turn off (deactivate) the swap file
sudo swapoff /swapfile
# 'sudo'         : Run the command as root (administrator), required for swap operations.
# 'swapoff'      : Command to disable a swap area.
# '/swapfile'    : The path to the swap file you want to disable.

# 2. Remove the swap file from disk
sudo rm /swapfile
# 'sudo'         : Run as root.
# 'rm'           : Remove (delete) a file.
# '/swapfile'    : The file to delete (your swap file).

# 3. (If you made swap permanent) Remove the swap entry from /etc/fstab
# Edit /etc/fstab with your favorite editor and delete the line:
# /swapfile none swap sw 0 0
# '/swapfile'    : Path to the swap file.
# 'none'         : No mount point needed for swap.
# 'swap'         : Filesystem type (swap area).
# 'sw'           : Options for swap.
# '0 0'          : Dump and fsck options (not used for swap).
# This prevents the swap file from being enabled at boot.

# 4. (Optional) Check swap status to confirm removal
swapon --show
# 'swapon'       : Command to manage swap areas.
# '--show'       : Display all active swap areas and their details.

#############################################
# Allocate 40 GB Swap RAM on Linux
#############################################

# 1. Create a 40 GB swap file (change path if needed)
sudo fallocate -l 40G /swapfile
# 'sudo'         : Run as root.
# 'fallocate'    : Quickly allocate space for a file without writing zeros.
# '-l 40G'       : Set the file size to 40 gigabytes (G = gigabytes).
# '/swapfile'    : The file to create and use as swap.

# 2. Set correct permissions so only root can read/write
sudo chmod 600 /swapfile
# 'sudo'         : Run as root.
# 'chmod'        : Change file permissions.
# '600'          : Only the owner (root) can read and write; no permissions for others.
# '/swapfile'    : The file to set permissions on.

# 3. Set up the swap area on the file
sudo mkswap /swapfile
# 'sudo'         : Run as root.
# 'mkswap'       : Set up a Linux swap area on a file or device.
# '/swapfile'    : The file to format as swap.

# 4. Enable the swap file
sudo swapon /swapfile
# 'sudo'         : Run as root.
# 'swapon'       : Enable a swap area for use.
# '/swapfile'    : The swap file to activate.

# 5. (Optional) Make swap permanent (so it works after reboot)
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
# 'echo ...'     : Output the text between quotes.
# '/swapfile'    : Path to the swap file.
# 'none'         : No mount point (not needed for swap).
# 'swap'         : Filesystem type.
# 'sw'           : Options for swap.
# '0 0'          : Dump and fsck options (not used for swap).
# '|'            : Pipe the output to the next command.
# 'sudo tee -a'  : As root, append ('-a') the line to the file (/etc/fstab).
# '/etc/fstab'   : System file that lists filesystems and swap to mount/enable at boot.

# 6. Check swap status
swapon --show
# 'swapon'       : Manage swap areas.
# '--show'       : Display all active swap areas and their details.

# 7. To remove swap later:
# sudo swapoff /swapfile         # Deactivate swap (see above for explanation)
# sudo rm /swapfile              # Delete the swap file (see above)
# Remove the line from /etc/fstab if you added it (see above)

#############################################