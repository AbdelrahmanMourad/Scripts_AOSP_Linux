#!/bin/bash
#
# Script: build_aosp.sh
# Purpose: Setup environment and build AOSP (Android Open Source Project)
# Author: You :)
#
# NOTE:
# - Make sure you have at least 16GB RAM (32GB recommended)
# - At least 200GB free disk space
# - First build may take several hours depending on CPU power
#

### STEP 1: Update and install required packages
sudo apt update -y
sudo apt upgrade -y

# Essential tools
sudo apt install -y git curl unzip openjdk-8-jdk qemu-system python3 gcc \
    flex bison g++-multilib build-essential zip \
    libncurses5-dev zlib1g-dev gawk \
    libssl-dev python-is-python3

### STEP 2: Setup working directory for AOSP
cd ~
mkdir -p aosp
cd aosp

### STEP 3: Install "repo" tool (used to fetch AOSP source)
mkdir -p ~/bin
export PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

### STEP 4: Initialize AOSP repo
# "android-latest-release" branch is used here, you can change it to android-14.0.0_rX for stable release
repo init -u https://android.googlesource.com/platform/manifest -b android-latest-release

### STEP 5: Sync the source (this may take a long time)
repo sync -c -j$(nproc)

### STEP 6: Setup environment for build
source build/envsetup.sh

### STEP 7: Choose a target
# Example: build AOSP for x86_64 emulator
lunch aosp_x86_64-eng

### STEP 8: Build AOSP
# Use all CPU cores to speed up
make -j$(nproc)

### STEP 9: Location of output
# After build completes, images will be inside:
# out/target/product/<target_name>/
# Example:
# out/target/product/generic_x86_64/system.img
# out/target/product/generic_x86_64/boot.img

### STEP 10: Run emulator (if you built emulator image)
emulator

