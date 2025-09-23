#!/bin/bash
# Ubuntu full update + laptop drivers status check + CUDA samples setup
# Save as ~/update_drivers.sh && chmod +x ~/update_drivers.sh
# =====================================================================
# Title:    Ubuntu Driver & CUDA Setup Script
# Author:   Mourad
# Date:     24th, Sep, 2025
# Purpose:  Keep ALL system drivers up-to-date on Ubuntu 24.04
#           AND auto-install CUDA samples (deviceQuery, etc.)
# =====================================================================


# Define log file with timestamp (all output saved here).
LOGFILE=~/update_drivers_$(date +%F).log

# Print starting message.
echo "=== 🚀 Starting full system update, driver check & CUDA setup ===" | tee $LOGFILE


# -------------------------------
# SECTION 0: Install dependencies
# -------------------------------
# Install common developer tools and libraries needed for drivers & CUDA samples.
echo
echo "=== [0/5] Installing essential dependencies ===" | tee -a $LOGFILE
sudo apt -y install build-essential dkms linux-headers-$(uname -r) \
    git cmake pkg-config wget curl unzip inxi | tee -a $LOGFILE



# ------------------------------
# SECTION 1: Update repositories
# ------------------------------
# 'apt update' refreshes available packages (metadata)
# 'apt upgrade' upgrades installed packages
# 'dist-upgrade' handles dependency changes (smarter than upgrade)
# '-y' flag answers "yes" automatically for prompts
echo
echo "=== [1/5] Updating system packages ===" | tee -a $LOGFILE
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
echo "=== [2/5] Checking & installing recommended drivers ===" | tee -a $LOGFILE
sudo ubuntu-drivers autoinstall | tee -a $LOGFILE


# --------------------------------
# SECTION 3: Clean up old packages
# --------------------------------
# 'autoremove' deletes unused dependencies (e.g., old kernels/drivers)
# 'autoclean' clears old package cache that is no longer downloadable
echo
echo "=== [3/5] Cleaning up old packages ===" | tee -a $LOGFILE
sudo apt -y autoremove | tee -a $LOGFILE
sudo apt -y autoclean | tee -a $LOGFILE


# -------------------------------
# SECTION 4: Driver status report
# -------------------------------
echo
echo "=== [4/5] System driver status report ===" | tee -a $LOGFILE

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


# --------------------------------------
# SECTION 5: NVIDIA CUDA Samples (deviceQuery)
# --------------------------------------
# This section ensures we always have a fresh copy of CUDA samples
# and builds the "deviceQuery" test to confirm CUDA is working.
# Steps:
# 1. Remove old ~/cuda-samples-official directory if exists
# 2. Clone latest NVIDIA CUDA samples repo
# 3. Go to "deviceQuery" folder
# 4. Build using make
# 5. Run ./deviceQuery and log results
echo
echo "=== [5/5] Setting up NVIDIA CUDA samples ===" | tee -a $LOGFILE

# Step 1: Remove old directory
if [ -d ~/cuda-samples-official ]; then
    echo "Removing old CUDA samples directory..." | tee -a $LOGFILE
    rm -rf ~/cuda-samples-official | tee -a $LOGFILE
fi

# Step 2: Clone CUDA samples repo
echo "Cloning CUDA samples repository..." | tee -a $LOGFILE
git clone --recursive https://github.com/NVIDIA/cuda-samples.git ~/cuda-samples-official | tee -a $LOGFILE

# Step 3: Navigate to deviceQuery sample
cd ~/cuda-samples-official/Samples/1_Utilities/deviceQuery || exit 1

# Step 4: Build with make (using all CPU cores)
echo "Building deviceQuery sample..." | tee -a $LOGFILE
make -j"$(nproc)" | tee -a $LOGFILE

# Step 5: Run deviceQuery and log output
if [ -f ./deviceQuery ]; then
    echo "Running deviceQuery test..." | tee -a $LOGFILE
    ./deviceQuery | tee -a $LOGFILE
else
    echo "❌ Build failed: deviceQuery binary not found!" | tee -a $LOGFILE
fi



# ----------------------
# FINAL WRAP-UP MESSAGE
# ----------------------
echo
echo "=== ✅ Driver update, CUDA setup & status check complete ===" | tee -a $LOGFILE
echo "Log saved to: $LOGFILE"