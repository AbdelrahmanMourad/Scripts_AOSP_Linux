1  sudo apt update
2  sudo apt install open-vm-tools-desktop -y 
3  sudo reboot
4  --version
5  -version
6  versoi
7  versoin
8  version
9  -version
10  --version
11  ubuntu --version
12  clear
13  pwd
# Print Working Directory.
14  ls
15  mkdir My_Workspace
16  ls
17  cd My_Workspace/
18  mkdir WORKING_DIRECTORY
19  LS
20  ls
21  cd WORKING_DIRECTORY/
22  repo init --partial-clone --no-use-superproject -b android-latest-release -u https://android.googlesource.com/platform/manifest
23  history
24  clear
25  history
26  repo init --partial-clone --no-use-superproject -b android-latest-release -u https://android.googlesource.com/platform/manifest
27  sudo apt install repo
28  repo init --partial-clone --no-use-superproject -b android-latest-release -u https://android.googlesource.com/platform/manifest
29  git config --global user.email "abdelrahmanmourad.am@gmail.com"
30  git config --global user.name "Mourad"
31  repo init --partial-clone --no-use-superproject -b android-latest-release -u https://android.googlesource.com/platform/manifest
32  clear
33  sudo apt-get install git-core gnupg flex bison build-essential zip curl zlib1g-dev libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
34  sudo apt-get update
35  sudo apt-get install repo
36  export REPO=$(mktemp /tmp/repo.XXXXXXXXX)
37  curl -o ${REPO} https://storage.googleapis.com/git-repo-downloads/repo
38  gpg --recv-keys 8BB9AD793E8E6153AF0F9A4416530D5E920F5C65
39  curl -s https://storage.googleapis.com/git-repo-downloads/repo.asc | gpg --verify - ${REPO} && install -m 755 ${REPO} ~/bin/repo
40  repo version 
41  cd ~
42  ls
43  mkdir aosp
44  ls
45  cd aosp
46  repo init --partial-clone -b android-latest-release -u https://android.googlesource.com/platform/manifest
47  repo sync -c -j8
48  df -h
49  df -i
50  sudo apt update
51  sudo apt install openjdk-8-jdk
52  sudo apt-get update
53  sudo apt-get install git-core gnupg flex bison build-essential zip curl zlib1g-dev libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
54  sudo apt install git
55  htop
56  sudo apt install htop
57  htop
58  history





###############################################################
1  sudo apt update                                   
# Update the list of available packages and their versions

2  sudo apt install open-vm-tools-desktop -y         
# Install VMware desktop integration tools for better VM experience

3  sudo reboot                                       
# Reboot the system

4  --version                                         
# (Incomplete command, usually used to check version of a program)

5  -version                                          
# (Incomplete command, usually used to check version of a program)

6  versoi                                            
# (Typo, does nothing)

7  versoin                                           
# (Typo, does nothing)

8  version                                           
# (Incomplete command, usually used to check version of a program)

9  -version                                          
# (Duplicate, incomplete)

10  --version                                        
# (Duplicate, incomplete)

11  ubuntu --version                                 
# (Invalid command, 'ubuntu' does not have a --version flag)

12  clear                                            
# Clear the terminal screen

13  pwd                                              
# Print the current working directory

14  ls                                               
# List files and directories in the current directory

15  mkdir My_Workspace                               
# Create a directory named 'My_Workspace'

16  ls                                               
# List files and directories

17  cd My_Workspace/                                 
# Change directory to 'My_Workspace'

18  mkdir WORKING_DIRECTORY                          
# Create a directory named 'WORKING_DIRECTORY'

19  LS                                               
# (Typo, should be 'ls')

20  ls                                               
# List files and directories

21  cd WORKING_DIRECTORY/                            
# Change directory to 'WORKING_DIRECTORY'

22  repo init --partial-clone --no-use-superproject -b android-latest-release -u https://android.googlesource.com/platform/manifest   
# Initialize a new repo client for AOSP with partial clone and no superproject

23  history                                          
# Show the command history

24  clear                                            
# Clear the terminal screen

25  history                                          
# Show the command history

26  repo init --partial-clone --no-use-superproject -b android-latest-release -u https://android.googlesource.com/platform/manifest   
# (Duplicate, initializes repo)

27  sudo apt install repo                            
# Install the 'repo' tool from the package manager

28  repo init --partial-clone --no-use-superproject -b android-latest-release -u https://android.googlesource.com/platform/manifest   
# (Duplicate, initializes repo)

29  git config --global user.email "abdelrahmanmourad.am@gmail.com"   
# Set the global Git user email

30  git config --global user.name "Mourad"           
# Set the global Git user name

31  repo init --partial-clone --no-use-superproject -b android-latest-release -u https://android.googlesource.com/platform/manifest   
# (Duplicate, initializes repo)

32  clear                                            
# Clear the terminal screen

33  sudo apt-get install git-core gnupg flex bison build-essential zip curl zlib1g-dev libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig   
# Install essential packages and dependencies for building AOSP

34  sudo apt-get update                              
# Update the package list

35  sudo apt-get install repo                        
# Install the 'repo' tool

36  export REPO=$(mktemp /tmp/repo.XXXXXXXXX)        
# Create a temporary file for the repo binary and save its path to $REPO

37  curl -o ${REPO} https://storage.googleapis.com/git-repo-downloads/repo   
# Download the latest 'repo' binary to the temporary file

38  gpg --recv-keys 8BB9AD793E8E6153AF0F9A4416530D5E920F5C65   
# Retrieve the GPG key for verifying the repo binary

39  curl -s https://storage.googleapis.com/git-repo-downloads/repo.asc | gpg --verify - ${REPO} && install -m 755 ${REPO} ~/bin/repo   
# Verify and install the repo binary to ~/bin

40  repo version                                     
# Show the installed repo version

41  cd ~                                             
# Change directory to the home directory

42  ls                                               
# List files and directories

43  mkdir aosp                                       
# Create a directory named 'aosp'

44  ls                                               
# List files and directories

45  cd aosp                                          
# Change directory to 'aosp'

46  repo init --partial-clone -b android-latest-release -u https://android.googlesource.com/platform/manifest   
# Initialize the AOSP repo in the 'aosp' directory

47  repo sync -c -j8                                 
# Sync the repo with 8 parallel jobs, using current branch only

48  df -h                                            
# Show disk space usage in human-readable format

49  df -i                                            
# Show inode usage

50  sudo apt update                                  
# Update the package list

51  sudo apt install openjdk-8-jdk                   
# Install OpenJDK 8 (Java Development Kit)

52  sudo apt-get update                              
# Update the package list

53  sudo apt-get install git-core gnupg flex bison build-essential zip curl zlib1g-dev libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig   
# (Duplicate, installs build dependencies)

54  sudo apt install git                             
# Install Git

55  htop                                             
# Run the interactive process viewer

56  sudo apt install htop                            
# Install htop

57  htop                                             
# Run htop

58  history                                          
# Show the command history
