#!/bin/bash
# Shebang



# ==================================================================
# <-- Use your existing source directory here -->
#   (Must be the same as where you ran `repo sync` to download AOSP source)
# ==================================================================
cd ~/WORKSPACE/AOSP/AOSPAOSP_15.0.0_36   

# ==================================================================
# Set output directory for AOSP build for RPi5 Android_15.0.0_36 
#   (customize as needed, must be before the build commands)
# ==================================================================
export OUT_DIR=~/WORKSPACE/AOSP_15.0.0_36/out_AOSP15_RPi5



# ==================================================================
# Fix: (workaround to allow unpriviliged user namespace through Apparmor) 
# ==================================================================
sudo sysctl -w kernel.apparmor_restrict_unprivileged_unconfined=0 
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0 


# =================================================================
# Hardware List:
    # SD Card 64 GB + USB card reader
    # Power supply Adapter 5.1 V
    # Rasberypi 5 Modle B Board without computation modle.
    # UCB to Type C Cable
    # Mini HDMi to HDMI cable
# =================================================================


# =================================================================
# Tools on Build Machine:
    # Git, Repo
    # OpenJDK-11-jdk
    # imager_1.8.5_amd64 or Balena-etcher
# =================================================================
# 
# ----------------
# OpenJDK-11-jdk:
# ----------------
sudo apt-get update
sudo apt-get install openjdk-11-jdk
java -version
# 
# ----------
# Repo Tool:
# ----------
mkdir ~/bin/repo
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
# 
# ----
# Git:
# ----
sudo apt-get install git
git config --global user.name "AbdelrahmanMourad"
git config --global user.email "abdelrahmanmourad.am@gmail.com"


# =================================================================
# Download Android 15 AOSP Source for Raspberry Pi 5
# =================================================================
# 
# 
# Install the required packages on the Build Machine
sudo apt-get install bc coreutils dosfstools e2fsprogs fdisk kpartx mtools ninja-build pkg-config python3-pip
sudo pip3 install meson mako jinja2 ply pyyaml dataclasses
#
# ----------------
# Initialize repo:
# ----------------
repo init -u https://android.googlesource.com/platform/manifest -b android-15.0.0_r36
curl -o .repo/local_manifests/manifest_brcm_rpi.xml -L https://raw.githubusercontent.com/raspberry-vanilla/android_local_manifest/android-15.0/manifest_brcm_rpi.xml --create-dirs
# #
# # Or optionally, you can reduce download size by creating a shallow clone and removing unneeded projects
# repo init -u https://android.googlesource.com/platform/manifest -b android-15.0.0_r36 --depth=1
# curl -o .repo/local_manifests/manifest_brcm_rpi.xml -L https://raw.githubusercontent.com/raspberry-vanilla/android_local_manifest/android-15.0/manifest_brcm_rpi.xml --create-dirs
# curl -o .repo/local_manifests/remove_projects.xml -L https://raw.githubusercontent.com/raspberry-vanilla/android_local_manifest/android-15.0/remove_projects.xml
# #
# ------------------------------
# Repo Sync once Repo Init done:
# ------------------------------
# repo sync -jn
repo sync
#
# ==================================================================
# Fix: (Clean the old builds workaround) 
# ==================================================================
make clean
#
# ==================================================================
# Fix: (Repo sync issues workaround) 
# ==================================================================
repo sync -c -j$(nproc --all) --force-sync
#
# ==================================================================
# Fix: (Clean the old builds workaround) 
# ==================================================================
make clean



# =================================================================
# Builf AOSP Source for Raspberry Pi 5
# =================================================================
#
#
# --------------------------------
# Setup Android build environment:
# --------------------------------
source build/envsetup.sh
#
#-----------------------------------------
# Check for lunch options
# ------------------------
    # aosp_rpi4_car-trunk_staging-userdebug
    # aosp_rpi4-trunk_staging-userdebug
    # aosp_rpi4_tv-trunk_staging-userdebug

    # ---> aosp_rpi5_car-trunk_staging-userdebug
    
    # aosp_rpi5-trunk_staging-userdebug
    # aosp_rpi5_tv-trunk_staging-userdebug
#-----------------------------------------
# Pick “aosp_rpi5_car-trunk_staging-userdebug” for Raspberry Pi 5 Automotive OS Build.
lunch aosp_rpi5_car-trunk_staging-userdebug
#
# ============================================
# ============Output Configuration============
# ============================================
# PLATFORM_VERSION_CODENAME=VanillaIceCream
# PLATFORM_VERSION=VanillaIceCream
# TARGET_PRODUCT=aosp_rpi5_car
# TARGET_BUILD_VARIANT=userdebug
# TARGET_ARCH=arm64
# TARGET_ARCH_VARIANT=armv8-a
# TARGET_CPU_VARIANT=cortex-a76
# TARGET_2ND_ARCH=arm
# TARGET_2ND_ARCH_VARIANT=armv7-a-neon
# TARGET_2ND_CPU_VARIANT=generic
# HOST_OS=linux
# HOST_OS_EXTRA=Linux-6.8.0-51-generic-x86_64-Ubuntu-22.04.5-LTS
# HOST_CROSS_OS=windows
# BUILD_ID=AP4A.250105.002
# OUT_DIR=out
# ============================================
#
#
#
# ----------------------------
# Build AOSP-15 System Images:
# ----------------------------
make bootimage systemimage vendorimage -j$(nproc)
# $ m
# Once system images are generated they will be stored at “ out/target/product/rpi5/”.


# # ==================================================================
# make bootimage systemimage vendorimage -j$(nproc)
# what is the difference between this line and the command : "m"
# # ---------------------------------------------------------------------
# # Answer:
# # ---------------------------------------------------------------------
# #
# Great question! Here’s the difference:

# make bootimage systemimage vendorimage -j$(nproc)
# Explicitly builds only the bootimage, systemimage, and vendorimage targets.
# These are the main images you need to flash/run Android on your device.
# -j$(nproc) tells make to use all available CPU cores for faster building.
# m
# m is a convenience wrapper script provided by the Android build system.
# Running m (with no arguments) builds the default targets for your current lunch configuration (usually droid, which builds everything needed for a full Android build).
# You can also run m bootimage systemimage vendorimage to do the same as the make command above, but using the wrapper.
# Summary:

# make bootimage systemimage vendorimage ... builds only those images.
# m (with no arguments) builds everything (full build).
# m with targets is equivalent to make with those targets, but is often preferred in Android builds because it sets up the environment automatically.
# Tip:
# For most Android builds, using m is recommended for convenience and reliability.
# # ==================================================================





# # Search for RPi5 related files in device/ directory
# grep -rnw . -e 'com.android.ranging'