#!/bin/bash
# =====================================================================
# setup_aosp_env.sh
# Purpose:
#   Set up Ubuntu environment for building Android Automotive (AOSP)
#   + Install dependencies
#   + Configure Git and Repo
#   + Download AOSP source tree (clone, sync)
#   + Optional: Setup Cuttlefish emulator + Swap memory
# =====================================================================

# -------------------------------
# SECTION 1: System Preparation
# -------------------------------
echo "=== [1/6] Updating system and installing essentials ==="
sudo apt update -y   # Updates package list
sudo apt upgrade -y  # Upgrades installed packages to latest versions

# Install basic utilities (VM tools, monitoring tools)
sudo apt install -y open-vm-tools-desktop htop

# -------------------------------
# SECTION 2: Development Dependencies
# -------------------------------
echo "=== [2/6] Installing build dependencies for AOSP ==="
sudo apt install -y \
  git-core gnupg flex bison build-essential zip curl zlib1g-dev \
  libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev \
  libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig \
  openjdk-8-jdk

# Additional dev tools (optional but recommended for Android dev)
sudo apt install -y git devscripts equivs config-package-dev debhelper-compat golang

# -------------------------------
# SECTION 3: Git Configuration
# -------------------------------
echo "=== [3/6] Configuring Git identity ==="
git config --global user.email "abdelrahmanmourad.am@gmail.com"
git config --global user.name "AbdelrahmanMourad"

# -------------------------------
# SECTION 4: Repo Tool Setup
# -------------------------------
echo "=== [4/6] Setting up 'repo' tool for AOSP ==="
mkdir -p ~/bin
export PATH=~/bin:$PATH

# Download latest repo binary
REPO=$(mktemp /tmp/repo.XXXXXXXXX)
curl -o ${REPO} https://storage.googleapis.com/git-repo-downloads/repo

# Import Google GPG key for verification
gpg --recv-keys 8BB9AD793E8E6153AF0F9A4416530D5E920F5C65

# Verify and install repo
curl -s https://storage.googleapis.com/git-repo-downloads/repo.asc \
  | gpg --verify - ${REPO} && install -m 755 ${REPO} ~/bin/repo

# Check repo version
repo version

# -------------------------------
# SECTION 5: Download AOSP Source
# -------------------------------
echo "=== [5/6] Initializing and syncing AOSP source ==="
mkdir -p ~/WORKSPACE/aosp && cd ~/aosp

# Init repo (partial clone for faster sync, no superproject)
repo init --partial-clone --no-use-superproject \
  -b android-latest-release \
  -u https://android.googlesource.com/platform/manifest

# Sync sources (with 8 parallel jobs)
repo sync -c -j8

# Show disk usage (just for user info)
df -h
df -i

# -------------------------------
# SECTION 6: (Optional) Setup Android Cuttlefish Emulator
# -------------------------------
echo "=== [6/6] Setting up Android Cuttlefish emulator (optional) ==="
cd ~/WORKSPACE
git clone https://github.com/google/android-cuttlefish
cd android-cuttlefish

# Build Cuttlefish packages
tools/buildutils/build_packages.sh

# Install missing dependency for runtime
sudo apt install -y libtinfo5

# # -------------------------------
# # SECTION 7: (Optional) Swap Setup for Large Builds
# # -------------------------------
# echo "=== [Optional] Creating 22GB swap file for builds ==="
# sudo swapoff -a  # Disable all swaps temporarily
# sudo dd if=/dev/zero of=/swapfile bs=1M count=22192 status=progress
# sudo chmod 0600 /swapfile       # Secure permissions
# sudo mkswap /swapfile           # Set up as swap space
# sudo swapon /swapfile           # Enable swap

echo "=== Setup completed successfully! ==="
