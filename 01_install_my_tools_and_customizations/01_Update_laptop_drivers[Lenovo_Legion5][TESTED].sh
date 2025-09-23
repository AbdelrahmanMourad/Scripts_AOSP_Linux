#!/bin/bash
# Ubuntu full update + laptop drivers status check
# Save as ~/update_drivers.sh && chmod +x ~/update_drivers.sh
# =====================================================================
# Ubuntu Driver & System Update Script
# Author:   Mourad
# Date:     22nd, Sep, 2025
# Purpose:  Keep ALL system drivers up-to-date on Ubuntu 24.04
# =====================================================================

# Define loge file with timestamp.
LOGFILE=~/update_drivers_$(date +%F).log

# Print starting message.
echo "=== 🚀 Starting full system update & driver check ===" | tee $LOGFILE


# ------------------------------
# SECTION 1: Update repositories
# ------------------------------
# 'apt update' refreshes the list of available packages (metadata)
# 'apt upgrade' upgrades already installed packages to the latest version
# '-y' flag answers "yes" automatically for prompts
echo
echo "=== [1/4] Updating system packages ===" | tee -a $LOGFILE
sudo apt update | tee -a $LOGFILE
sudo apt -y upgrade | tee -a $LOGFILE
sudo apt -y dist-upgrade | tee -a $LOGFILE

# 'dist-upgrade' is smarter than 'upgrade':
# it can install/remove packages to complete the upgrade if dependencies change


# ---------------------------------------------
# SECTION 2: Install latest recommended drivers
# ---------------------------------------------
# 'ubuntu-drivers autoinstall' detects all hardware
# (GPU, Wi-Fi, etc.) and installs the best recommended driver versions
echo
echo "=== [2/4] Checking & installing recommended drivers ===" | tee -a $LOGFILE
sudo ubuntu-drivers autoinstall | tee -a $LOGFILE


# --------------------------------
# SECTION 3: Clean up old packages
# --------------------------------
# 'autoremove' deletes unused dependencies (e.g., old kernels/drivers)
# 'autoclean' clears old package cache that is no longer downloadable
echo
echo "=== [3/4] Cleaning up old packages ===" | tee -a $LOGFILE
sudo apt -y autoremove | tee -a $LOGFILE
sudo apt -y autoclean | tee -a $LOGFILE


# -------------------------------
# SECTION 4: Driver status report
# -------------------------------
echo
echo "=== [4/4] System driver status report ===" | tee -a $LOGFILE

# Kernel version info
echo "--- Kernel version ---" | tee -a $LOGFILE
uname -r | tee -a $LOGFILE

# GPU devices and drivers
echo "--- GPU devices & loaded drivers ---" | tee -a $LOGFILE
lspci -k | grep -A 3 -E "VGA|3D" | tee -a $LOGFILE

# GPU summary with inxi
echo "--- inxi GPU summary ---" | tee -a $LOGFILE
if command -v inxi >/dev/null 2>&1; then
    inxi -G | tee -a $LOGFILE
else
    echo "Installing inxi for detailed GPU info..." | tee -a $LOGFILE
    sudo apt -y install inxi | tee -a $LOGFILE
    inxi -G | tee -a $LOGFILE
fi

# Direct Rendering Infrastructure nodes (GPU active check)
echo "--- DRI nodes (/dev/dri) ---" | tee -a $LOGFILE
ls -l /dev/dri/ | tee -a $LOGFILE

# Kernel modules in use (GPU, Wi-Fi, Bluetooth, etc.)
echo "--- Kernel modules (GPU, Wi-Fi, BT) ---" | tee -a $LOGFILE
lsmod | egrep "nvidia|i915|amdgpu|btusb|iwlwifi|ath|realtek" | tee -a $LOGFILE

# Full PCI device/driver list (all hardware on the PCI bus)
echo "--- All PCI devices & drivers ---" | tee -a $LOGFILE
lspci -k | tee -a $LOGFILE

# USB devices (covers Wi-Fi dongles, Bluetooth, peripherals, etc.)
echo "--- USB devices ---" | tee -a $LOGFILE
lsusb | tee -a $LOGFILE

# Final message
echo
echo "=== ✅ Driver update & status check complete ===" | tee -a $LOGFILE
echo "Log saved to: $LOGFILE"