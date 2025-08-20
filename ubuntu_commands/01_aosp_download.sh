1  sudo apt update
2  sudo apt install open-vm-tools-desktop -y 
3  sudo reboot
4  clear
5  pwd
6  ls
7  mkdir My_Workspace
8  ls
9  cd My_Workspace/
10  mkdir WORKING_DIRECTORY
11  ls
12  cd WORKING_DIRECTORY/
13  repo init --partial-clone --no-use-superproject -b android-latest-release -u https://android.googlesource.com/platform/manifest
14  history
15  clear
16  history
17  repo init --partial-clone --no-use-superproject -b android-latest-release -u https://android.googlesource.com/platform/manifest
18  sudo apt install repo
19  repo init --partial-clone --no-use-superproject -b android-latest-release -u https://android.googlesource.com/platform/manifest
20  git config --global user.email "abdelrahmanmourad.am@gmail.com"
21  git config --global user.name "Mourad"
22  repo init --partial-clone --no-use-superproject -b android-latest-release -u https://android.googlesource.com/platform/manifest
23  clear
24  sudo apt-get install git-core gnupg flex bison build-essential zip curl zlib1g-dev libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
25  sudo apt-get update
26  sudo apt-get install repo
27  export REPO=$(mktemp /tmp/repo.XXXXXXXXX)
28  curl -o ${REPO} https://storage.googleapis.com/git-repo-downloads/repo
29  gpg --recv-keys 8BB9AD793E8E6153AF0F9A4416530D5E920F5C65
30  curl -s https://storage.googleapis.com/git-repo-downloads/repo.asc | gpg --verify - ${REPO} && install -m 755 ${REPO} ~/bin/repo
31  repo version 
32  cd ~
33  ls
34  mkdir aosp
35  ls
36  cd aosp
37  repo init --partial-clone -b android-latest-release -u https://android.googlesource.com/platform/manifest
38  repo sync -c -j8
39  df -h
40  df -i
41  sudo apt update
42  sudo apt install openjdk-8-jdk
43  sudo apt-get update
44  sudo apt-get install git-core gnupg flex bison build-essential zip curl zlib1g-dev libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
45  sudo apt install git
46  htop
47  sudo apt install htop
48  htop
49  sudo apt install -y git devscripts equivs config-package-dev debhelper-compat golang curl
50  git clone https://github.com/google/android-cuttlefish
51  cd android-cuttlefish
52  tools/buildutils/build_packages.sh
53  sudo apt install libtinfo5
54  sudo swapoff -a
55  sudo dd if=/dev/zero of=/swapfile bs=1M count=22192
56  sudo chmod 0600 /swapfile
57  sudo mkswap /swapfile  # Set up a Linux swap area
58  sudo swapon /swapfile  # Turn the swap on
59  history













# 1  sudo apt update
#    Updates the list of available packages and their versions.

# 2  sudo apt install open-vm-tools-desktop -y 
#    Installs VMware desktop integration tools for better VM experience.

# 3  sudo reboot
#    Reboots the system.

# 12  clear
#     Clears the terminal screen.

# 13  pwd
#     Prints the current working directory.

# 14  ls
#     Lists files and directories in the current directory.

# 15  mkdir My_Workspace
#     Creates a directory named 'My_Workspace'.

# 16  ls
#     Lists files and directories.

# 17  cd My_Workspace/
#     Changes directory to 'My_Workspace'.

# 18  mkdir WORKING_DIRECTORY
#     Creates a directory named 'WORKING_DIRECTORY'.

# 20  ls
#     Lists files and directories.

# 21  cd WORKING_DIRECTORY/
#     Changes directory to 'WORKING_DIRECTORY'.

# 22  repo init --partial-clone --no-use-superproject -b android-latest-release -u https://android.googlesource.com/platform/manifest
#     Initializes a new repo client for AOSP with partial clone and no superproject.

# 23  history
#     Shows the command history.

# 24  clear
#     Clears the terminal screen.

# 25  history
#     Shows the command history.

# 26  repo init --partial-clone --no-use-superproject -b android-latest-release -u https://android.googlesource.com/platform/manifest
#     (Duplicate of above, initializes repo.)

# 27  sudo apt install repo
#     Installs the 'repo' tool from the package manager.

# 28  repo init --partial-clone --no-use-superproject -b android-latest-release -u https://android.googlesource.com/platform/manifest
#     (Duplicate, initializes repo.)

# 29  git config --global user.email "abdelrahmanmourad.am@gmail.com"
#     Sets the global Git user email.

# 30  git config --global user.name "Mourad"
#     Sets the global Git user name.

# 31  repo init --partial-clone --no-use-superproject -b android-latest-release -u https://android.googlesource.com/platform/manifest
#     (Duplicate, initializes repo.)

# 32  clear
#     Clears the terminal screen.

# 33  sudo apt-get install git-core gnupg flex bison build-essential zip curl zlib1g-dev libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
#     Installs essential packages and dependencies for building AOSP.

# 34  sudo apt-get update
#     Updates the package list.

# 35  sudo apt-get install repo
#     Installs the 'repo' tool.

# 36  export REPO=$(mktemp /tmp/repo.XXXXXXXXX)
#     Creates a temporary file for the repo binary and saves its path to $REPO.

# 37  curl -o ${REPO} https://storage.googleapis.com/git-repo-downloads/repo
#     Downloads the latest 'repo' binary to the temporary file.

# 38  gpg --recv-keys 8BB9AD793E8E6153AF0F9A4416530D5E920F5C65
#     Retrieves the GPG key for verifying the repo binary.

# 39  curl -s https://storage.googleapis.com/git-repo-downloads/repo.asc | gpg --verify - ${REPO} && install -m 755 ${REPO} ~/bin/repo
#     Verifies and installs the repo binary to ~/bin.

# 40  repo version 
#     Shows the installed repo version.

# 41  cd ~
#     Changes directory to the home directory.

# 42  ls
#     Lists files and directories.

# 43  mkdir aosp
#     Creates a directory named 'aosp'.

# 44  ls
#     Lists files and directories.

# 45  cd aosp
#     Changes directory to 'aosp'.

# 46  repo init --partial-clone -b android-latest-release -u https://android.googlesource.com/platform/manifest
#     Initializes the AOSP repo in the 'aosp' directory.

# 47  repo sync -c -j8
#     Syncs the repo with 8 parallel jobs, using current branch only.

# 48  df -h
#     Shows disk space usage in human-readable format.

# 49  df -i
#     Shows inode usage.

# 50  sudo apt update
#     Updates the package list.

# 51  sudo apt install openjdk-8-jdk
#     Installs OpenJDK 8 (Java Development Kit).

# 52  sudo apt-get update
#     Updates the package list.

# 53  sudo apt-get install git-core gnupg flex bison build-essential zip curl zlib1g-dev libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
#     (Duplicate, installs build dependencies.)

# 54  sudo apt install git
#     Installs Git.

# 55  htop
#     Runs the interactive process viewer.

# 56  sudo apt install htop
#     Installs htop.

# 57  htop
#     Runs htop.

# 58  sudo apt install -y git devscripts equivs config-package-dev debhelper-compat golang curl
#     Installs various development tools and dependencies.

# 59  git clone https://github.com/google/android-cuttlefish
#     Clones the Android Cuttlefish repository.

# 60  cd android-cuttlefish
#     Changes directory to 'android-cuttlefish'.

# 61  tools/buildutils/build_packages.sh
#     Runs the build script for Cuttlefish packages.

# 62  sudo apt install libtinfo5
#     Installs the libtinfo5 library (terminal info).

# 63  sudo swapoff -a
#     Disables all swap devices.

# 64  sudo dd if=/dev/zero of=/swapfile bs=1M count=22192
#     Creates a swap file of ~22GB.

# 65  # Set the correct permissions
#     (Comment: next command sets permissions.)

# 66  sudo chmod 0600 /swapfile
#     Sets secure permissions on the swap file.

# 67  sudo mkswap /swapfile  # Set up a Linux swap area
#     Sets up the swap file as swap space.

# 68  sudo swapon /swapfile  # Turn the swap on
#     Enables the swap file.

# 69  history
#     Shows the command history.