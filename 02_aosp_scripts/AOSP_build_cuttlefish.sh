#!/bin/bash
# The shebang (#!) at the top tells the system to use the Bash shell to interpret this script.
# It ensures your script runs with the correct shell, regardless of the user's default shell.
# This is important for compatibility and to avoid unexpected behavior if the script uses Bash-specific features.
# Always place the shebang as the very first line in your script.


#######
# AOSP
#######
# ==================================================================
# <-- Use your existing source directory here -->
#   (Must be the same as where you ran `repo sync` to download AOSP source)
# ==================================================================
cd ~/WORKSPACE/AOSP/AOSPAOSP_15.0.0_36   

# ==================================================================
# Set output directory for AOSP build for RPi5 Android_15.0.0_36 
#   (customize as needed, must be before the build commands)
# ==================================================================
export OUT_DIR=~/WORKSPACE/AOSP_15.0.0_36/out_AOSP15_CF
# export OUT_DIR=~/WORKSPACE/AOSP_15.0.0_36/out_AOSP15_RPi5


# ==================================================================
# Fix: (workaround to allow unpriviliged user namespace through Apparmor) 
# ==================================================================
sudo sysctl -w kernel.apparmor_restrict_unprivileged_unconfined=0 
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0 
#
#
# Install required packages
#   To install required packages for Ubuntu 18.04 or later, run the following command:
sudo apt-get install git-core gnupg flex bison build-essential zip curl zlib1g-dev libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
#
#
# # ==================
# # Install Repo tool:
# # ==================
# #   1. Download the current package information:
# sudo apt-get update
# #
# #   2. Run the following command to install the Repo launcher:
# #       The Repo launcher provides a Python script that initializes a checkout and downloads the full Repo tool.
# #       If successful, skip to step 4.
# sudo apt-get install repo
# #
# #   3. (optional) Manually install Repo using the following series of commands:
# #       The first three commands set up a temp file, download Repo to the file, and verify that the key provided 
# #       matches the required key. If these commands are successful, the final command installs the Repo launcher.
# export REPO=$(mktemp /tmp/repo.XXXXXXXXX)
# curl -o ${REPO} https://storage.googleapis.com/git-repo-downloads/repo
# gpg --recv-keys 8BB9AD793E8E6153AF0F9A4416530D5E920F5C65
# curl -s https://storage.googleapis.com/git-repo-downloads/repo.asc | gpg --verify - ${REPO} && install -m 755 ${REPO} ~/bin/repo
# #
# #   4. Verify the Repo launcher version:
# repo version
# # The output should indicate a version of 2.4 or higher, for example:
# #   repo launcher version 2.45
# #
#
#############################################
# Download The Android AOSP Source Code:
#############################################
#
# The Android source is located in a collection of Git repositories hosted by Google. 
#   Each Git repository includes the entire history of the Android source, 
#   including changes to the source and when the changes were made. To download the Android source:
#
#   1. Navigate into your home directory:
cd ~/WORKSPACE/
#
#   2. Create a local working subdirectory within it:
mkdir AOSP
#
#   3. Navigate into the directory:
cd AOSP
#
#   4. Initialize the AOSP repository source code latest release branch (android-latest-release):
repo init --partial-clone -b android-latest-release -u https://android.googlesource.com/platform/manifest
#
#   5. Enter or accept your Git credentials (name, email address).
#       These credentials are used to track your changes to the source code.
git config --global user.name "AbdelrahmanMourad"
git config --global user.email "abdelrahmanmourad.am@gmail.com"
#
#   6. Sync the source code:
repo sync -c -j8
#
#
# 
# 
#############################################
# Build AOSP for Cuttlefish
#############################################
#
#   To build the code:
#       1. From within your working directory, source the envsetup.sh script 
#           to set up your build environment:
source build/envsetup.sh
#
#       2. Specify a target device type to build with the lunch command. 
#           A target is a device permutation, such as a specific model or form factor. Specify this target:
# lunch aosp_cf_x86_64_only_auto-aosp_current-userdebug
lunch aosp_cf_x86_64_auto-trunk_staging-userdebug
# lunch aosp_rpi5_car-trunk_staging-userdebug
#
#           You should see a synopsis of your target and build environment:
#           ============================================
#           PLATFORM_VERSION_CODENAME=Baklava
#           PLATFORM_VERSION=Baklava
#           TARGET_PRODUCT=aosp_cf_x86_64_only_auto
#           TARGET_BUILD_VARIANT=userdebug
#           TARGET_ARCH=x86_64
#           TARGET_ARCH_VARIANT=silvermont
#           HOST_OS=linux
#           HOST_OS_EXTRA=Linux-6.10.11-1rodete2-amd64-x86_64-Debian-GNU/Linux-rodete
#           HOST_CROSS_OS=windows
#           BUILD_ID=BP1A.250305.020
#           OUT_DIR=out
#           ============================================
#
#
#       3. Build the target:
m
# Expect the first build to take hours. 
#   Subsequent builds take significantly less time. The output of your build appears in $OUT_DIR.
#
#
###########################
# Cuttlefish Emulator Build
###########################
cd ~/WORKSPACE/             
dy -d 1 -h                          # Check folders sizes.
cd ~/WORKSPACE/AOSP_15.0.0_36/      # Change to AOSP directory.
ls -l                               # Directory Structure - List files in the current directory.  
# for now let's ignore all these folders, and focus on the directory device/
# the device folder is intended to host all the open source android customization code.
# it's where we would add our own customized system service
cd device
ls -l
# in the google folder, we can find the open source code for the supported google phones
# for this checkout branch 
# The code name of these phones are named after a fish
# for example redfin is code name for pixel 5. 
# for testing any platform code, we should start coding on a virtual device
# and once the service has worked on the virtual device, we can add it to our target device service list.
#
# The cuttlefish image is a configurable virtual android device that includes all the framework code and any 
# custom platform code like the one we're planning to add in the future.
# The cuttlefish image is a replacement for the android emulator for AOSP developers.
#
# Going back to the AOSP folder.
cd ../../
#
#
# Before we can start the cuttlefish image build, we will need to load the lunch script 
#   along with other useful development tools so we can build android.
# This is done by sourcing the build/envsetup.sh shell script.
source buid/envsetup.sh
#
# Now we can see the full list of available commands by running hmm.
hmm
#
# Let's go over some inportant commands:
#   -   lunch:  The lunch command will be used for selecting a specific image to build.
#               We will use it shortly to select the "cuttlefish x86_64 auto user debug image".    
#   -   m:      The m command is used to build the selected image {Current Directory}.
#               It will build the image using all available CPU cores.
#               This will take a while, so be patient.
#   -   mm:     The mm command is used to build all the modules in the current directory.
#               This is useful when you are working on a specific module and want to build
#               only that module instead of the entire image.
#   -   mmm:    The mmm command is used to build all the modules in a specific directory.
#               This is useful when you are working on a specific directory and want
#               to build all the modules in that directory.
#   -   gomod:  Android is made out of modules whic hmust have a unique name.
#               The gomod command can show us the location of the settings app by just typing: "gomod settings"
gomod settings
#
# The "croot" command change the directory to the root of the source tree {AOSP Directory}.
croot
#
#
#
# To select a device to build, we will use the lunch command.
lunch
# The script has parsed the device directory and list all the found build combinations.
#   For cuttlefish, we have seven build combinations:
#       12. aosp_cf_arm64_auto-userdebug
#       13. aosp_cf_arm64_phone-userdebug
#       14. aosp_cf_x86_64_pc-userdebug
#       15. aosp_cf_x86_64_phone-userdebug
#       16. aosp_cf_x86_auto-userdebug
#       17. aosp_cf_x86_phone-userdebug
#       18. aosp_cf_x86_tv-userdebug
#
#   NOTE:
#       We can see that combinations have {"user","userdebug","eng"} endings.
#           -   user:       for production build.. it does not have root access.. 
#                               and adb (Android Deveoper Bridge) is disabled by default.
#           -   userdebug:  for development build.. it adds debugging features.. 
#                               adb is enabled by default.. 
#                               the "adb shell command" will open the running android linux shell screen.
#                               if we build with userdebug we can change to root by using {""su"""}
#           -   userdebug:  for development.
#                               similat to the userdebug.. but adh comes up in root mode without needing to ask you.
#
# we will select the "16. aosp_cf_x86_auto-userdebug" build combination by typing "16" or "aosp_cf_x86_auto-userdebug"
16. aosp_cf_x86_auto-userdebug
#
#   NOTE:   This number can be changed as more devices are added or removed.
#               So, it's always good to validate our selection.
#
# We're ready to start the build process by running the "m -j8" command
m -j8
# 
# 
# 
#######################################
# Build Cuttlefish Emulator
#######################################
#
# ========================
# Verify KVM availability
# ========================
#   Cuttlefish is a virtual device and is dependent on virtualization being available on the host machine.
#   In a terminal on your host machine, make sure that virtualization with a Kernel-based Virtual Machine (KVM) is available:
#
grep -c -w "vmx\|svm" /proc/cpuinfo# Install required packages using apt (the package manager for Ubuntu/Debian).
# -y: Automatically answer "yes" to prompts.
# The packages:
#   git: Version control system.
#   devscripts: Tools for Debian package development.
#   equivs: Helps create dummy Debian packages.
#   config-package-dev: Tools for managing configuration files in packages.
#   debhelper-compat: Compatibility helpers for building Debian packages.
#   golang: Go programming language (needed for some build tools).
#   curl: Tool to transfer data from or to a server (used for downloading files).
sudo apt install -y git devscripts equivs config-package-dev debhelper-compat golang curl

# Clone (download) the android-cuttlefish source code from GitHub.
git clone https://github.com/google/android-cuttlefish

# Change directory to the newly cloned android-cuttlefish folder.
cd android-cuttlefish

# Run the build script to create the necessary Debian (.deb) packages for Cuttlefish.
tools/buildutils/build_packages.sh

# Install the base Cuttlefish package.
# -i: Install the specified .deb package file.
# If installation fails (||), run 'sudo apt-get install -f' to fix broken dependencies.
sudo dpkg -i ./cuttlefish-base_*_*64.deb || sudo apt-get install -f

# Install the user Cuttlefish package, with the same error handling as above.
sudo dpkg -i ./cuttlefish-user_*_*64.deb || sudo apt-get install -f

# Add the current user ($USER) to the groups:
#   kvm: Allows access to hardware virtualization.
#   cvdnetwork: Allows networking for Cuttlefish virtual devices.
#   render: Allows access to GPU rendering.
# -aG: Add user to the listed groups.
sudo usermod -aG kvm,cvdnetwork,render $USER

# Reboot the system to apply group changes and load any required kernel modules.
sudo# Install required packages using apt (the package manager for Ubuntu/Debian).
# -y: Automatically answer "yes" to prompts.
# The packages:
#   git: Version control system.
#   devscripts: Tools for Debian package development.
#   equivs: Helps create dummy Debian packages.
#   config-package-dev: Tools for managing configuration files in packages.
#   debhelper-compat: Compatibility helpers for building Debian packages.
#   golang: Go programming language (needed for some build tools).
#   curl: Tool to transfer data from or to a server (used for downloading files).
sudo apt install -y git devscripts equivs config-package-dev debhelper-compat golang curl

# Clone (download) the android-cuttlefish source code from GitHub.
git clone https://github.com/google/android-cuttlefish

# Change directory to the newly cloned android-cuttlefish folder.
cd android-cuttlefish

# Run the build script to create the necessary Debian (.deb) packages for Cuttlefish.
tools/buildutils/build_packages.sh

# Install the base Cuttlefish package.
# -i: Install the specified .deb package file.
# If installation fails (||), run 'sudo apt-get install -f' to fix broken dependencies.
sudo dpkg -i ./cuttlefish-base_*_*64.deb || sudo apt-get install -f

# Install the user Cuttlefish package, with the same error handling as above.
sudo dpkg -i ./cuttlefish-user_*_*64.deb || sudo apt-get install -f

# Add the current user ($USER) to the groups:
#   kvm: Allows access to hardware virtualization.
#   cvdnetwork: Allows networking for Cuttlefish virtual devices.
#   render: Allows access to GPU rendering.
# -aG: Add user to the listed groups.
sudo usermod -aG kvm,cvdnetwork,render $USER

# Reboot the system to apply group changes and load any required kernel modules.
sudo# Install required packages using apt (the package manager for Ubuntu/Debian).
# -y: Automatically answer "yes" to prompts.
# The packages:
#   git: Version control system.
#   devscripts: Tools for Debian package development.
#   equivs: Helps create dummy Debian packages.
#   config-package-dev: Tools for managing configuration files in packages.
#   debhelper-compat: Compatibility helpers for building Debian packages.
#   golang: Go programming language (needed for some build tools).
#   curl: Tool to transfer data from or to a server (used for downloading files).
sudo apt install -y git devscripts equivs config-package-dev debhelper-compat golang curl

# Clone (download) the android-cuttlefish source code from GitHub.
git clone https://github.com/google/android-cuttlefish

# Change directory to the newly cloned android-cuttlefish folder.
cd android-cuttlefish

# Run the build script to create the necessary Debian (.deb) packages for Cuttlefish.
tools/buildutils/build_packages.sh

# Install the base Cuttlefish package.
# -i: Install the specified .deb package file.
# If installation fails (||), run 'sudo apt-get install -f' to fix broken dependencies.
sudo dpkg -i ./cuttlefish-base_*_*64.deb || sudo apt-get install -f

# Install the user Cuttlefish package, with the same error handling as above.
sudo dpkg -i ./cuttlefish-user_*_*64.deb || sudo apt-get install -f

# Add the current user ($USER) to the groups:
#   kvm: Allows access to hardware virtualization.
#   cvdnetwork: Allows networking for Cuttlefish virtual devices.
#   render: Allows access to GPU rendering.
# -aG: Add user to the listed groups.
sudo usermod -aG kvm,cvdnetwork,render $USER

# Reboot the system to apply group changes and load any required kernel modules.
sudo# Install required packages using apt (the package manager for Ubuntu/Debian).
# -y: Automatically answer "yes" to prompts.
# The packages:
#   git: Version control system.
#   devscripts: Tools for Debian package development.
#   equivs: Helps create dummy Debian packages.
#   config-package-dev: Tools for managing configuration files in packages.
#   debhelper-compat: Compatibility helpers for building Debian packages.
#   golang: Go programming language (needed for some build tools).
#   curl: Tool to transfer data from or to a server (used for downloading files).
sudo apt install -y git devscripts equivs config-package-dev debhelper-compat golang curl

# Clone (download) the android-cuttlefish source code from GitHub.
git clone https://github.com/google/android-cuttlefish

# Change directory to the newly cloned android-cuttlefish folder.
cd android-cuttlefish

# Run the build script to create the necessary Debian (.deb) packages for Cuttlefish.
tools/buildutils/build_packages.sh

# Install the base Cuttlefish package.
# -i: Install the specified .deb package file.
# If installation fails (||), run 'sudo apt-get install -f' to fix broken dependencies.
sudo dpkg -i ./cuttlefish-base_*_*64.deb || sudo apt-get install -f

# Install the user Cuttlefish package, with the same error handling as above.
sudo dpkg -i ./cuttlefish-user_*_*64.deb || sudo apt-get install -f

# Add the current user ($USER) to the groups:
#   kvm: Allows access to hardware virtualization.
#   cvdnetwork: Allows networking for Cuttlefish virtual devices.
#   render: Allows access to GPU rendering.
# -aG: Add user to the listed groups.
sudo usermod -aG kvm,cvdnetwork,render $USER

# Reboot the system to apply group changes and load any required kernel modules.
sudo
#   This command should return a nonzero value. If it returns 0, then your CPU does not support hardware virtualization,
#   or it is not enabled in the BIOS. If you are using a virtual machine as your host, then nested virtualization must be enabled.
#   If KVM is not available, you can still run Cuttlefish, but it will be much slower.
#   To install KVM on an Ubuntu host, run the following command:
sudo apt-get install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
#
#
# =================
# Launch Cuttlefish
# =================
#
#   1.  In a terminal window, download, build, and install the host Debian packages:
sudo apt install -y git devscripts equivs config-package-dev debhelper-compat golang curl
git clone https://github.com/google/android-cuttlefish
cd android-cuttlefish
tools/buildutils/build_packages.sh
sudo dpkg -i ./cuttlefish-base_*_*64.deb || sudo apt-get install -f
sudo dpkg -i ./cuttlefish-user_*_*64.deb || sudo apt-get install -f
sudo usermod -aG kvm,cvdnetwork,render $USER
sudo reboot
#       The reboot triggers installing additional kernel modules and applies udev rules.
#           __
#           ||
#           ||
#           ||
#           ||
#           ||
#           ||
#           ||
#      _____||_______
#      \            /    
#       \          /
#        \        /
#         \      /
#          \    /
#           \  /
#            \/

# Copilot explanation:
# Install required packages using apt (the package manager for Ubuntu/Debian).
# -y: Automatically answer "yes" to prompts.
# The packages:
#   git: Version control system.
#   devscripts: Tools for Debian package development.
#   equivs: Helps create dummy Debian packages.
#   config-package-dev: Tools for managing configuration files in packages.
#   debhelper-compat: Compatibility helpers for building Debian packages.
#   golang: Go programming language (needed for some build tools).
#   curl: Tool to transfer data from or to a server (used for downloading files).
sudo apt install -y git devscripts equivs config-package-dev debhelper-compat golang curl

# Clone (download) the android-cuttlefish source code from GitHub.
git clone https://github.com/google/android-cuttlefish

# Change directory to the newly cloned android-cuttlefish folder.
cd android-cuttlefish

# Run the build script to create the necessary Debian (.deb) packages for Cuttlefish.
tools/buildutils/build_packages.sh

# Install the base Cuttlefish package.
# -i: Install the specified .deb package file.
# If installation fails (||), run 'sudo apt-get install -f' to fix broken dependencies.
sudo dpkg -i ./cuttlefish-base_*_*64.deb || sudo apt-get install -f

# Install the user Cuttlefish package, with the same error handling as above.
sudo dpkg -i ./cuttlefish-user_*_*64.deb || sudo apt-get install -f

# Add the current user ($USER) to the groups:
#   kvm: Allows access to hardware virtualization.
#   cvdnetwork: Allows networking for Cuttlefish virtual devices.
#   render: Allows access to GPU rendering.
# -aG: Add user to the listed groups.
sudo usermod -aG kvm,cvdnetwork,render $USER

# Reboot the system to apply group changes and load any required kernel modules.
sudo reboot