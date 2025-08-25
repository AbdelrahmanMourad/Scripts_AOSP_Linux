
#!/bin/bash

# تحديث النظام System Update
sudo apt update -y
sudo apt upgrade -y

# Install Required Packages
sudo apt-get install git-core gnupg flex bison build-essential zip curl\
 zlib1g-dev libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev\
 libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
#
# Among the packages installed, this command installs Git, which is 
# used to download the AOSP source.
#


# Install important tools
sudo apt install -y open-vm-tools-desktop git-core gnupg flex bison build-essential zip curl zlib1g-dev \
libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip \
fontconfig openjdk-8-jdk htop qemu-system python3 gcc

# git settings configurations
git config --global user.email "abdelrahmanmourad.am@gmail.com"
git config --global user.name "Mourad"

# Repo tool install
mkdir -p ~/bin
export PATH=~/bin:$PATH
REPO=$(mktemp /tmp/repo.XXXXXXXXX)
curl -o ${REPO} https://storage.googleapis.com/git-repo-downloads/repo
gpg --recv-keys 8BB9AD793E8E6153AF0F9A4416530D5E920F5C65
curl -s https://storage.googleapis.com/git-repo-downloads/repo.asc | gpg --verify - ${REPO} \
  && install -m 755 ${REPO} ~/bin/repo

# AOSP folder creation
cd ~
mkdir -p aosp
cd aosp

# repo init.. clone
repo init --partial-clone -b android-latest-release -u https://android.googlesource.com/platform/manifest
repo sync -c -j8

