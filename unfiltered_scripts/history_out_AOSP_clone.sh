
    5  sudo apt install python
    6  sudo apt install python3
   
    8  free -h 
    9  du -h
   10  df -h
   11  lsblk
   12  sudo lsblk -l
   13  clear
   14  ls
   15  pwd
   16  mkdir WORKSPACE
   17  cd WORKSPACE/
   18  mkdir AOSP
   19  cd AOSP/
   20  ls
  
   21  sudo apt update
#   Install Dependencies
   22  sudo apt install git openjdk-17-jdk bc bison build-essential curl flex g++-multilib gcc-multilib gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync unzip x11proto-core-dev xsltproc zip zlib1g-dev
   23  sudo apt install libncurses-dev
   24  sudo dpkg --add-architecture i386
   
   26  sudo apt install lib32ncurses-dev

   28  sudo apt install git openjdk-17-jdk bc bison build-essential curl flex g++-multilib gcc-multilib gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync unzip x11proto-core-dev xsltproc zip zlib1g-dev
   29  sudo apt install libncurses-dev
   30  sudo dpkg --add-architecture i386
   
   32  sudo apt install lib32ncurses6-dev lib32readline-dev lib32z1-dev
   33  mkdir -p ~/bin
   34  curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
   35  chmod a+x ~/bin/repo
   36  export PATH=~/bin:$PATH
   37  lsblk
   38  sudo apt install gcc-multilib g++-multilib
   39  sudo apt install libncurses-dev libreadline-dev zlib1g-dev
   40  sudo apt install libssl-dev liblz4-tool libxml2-utils lzop pngcrush xsltproc unzip
   41  clear
   42  sudo apt install curl
   43  sudo apt update
   44  sudo apt install -y     openjdk-17-jdk     git-core     gnupg flex bison gperf build-essential     zip curl zlib1g-dev     gcc-multilib g++-multilib     libc6-dev-i386     libncurses-dev     x11proto-dev     libx11-dev     libgl1-mesa-dev     libxml2-utils xsltproc unzip     fontconfig
   45  repo init -u https://android.googlesource.com/platform/manifest -b android-15.0.0_r36
   46  repo sync -c -j$(nproc --all)
   47  repo init -u https://android.googlesource.com/platform/manifest -b android-15.0.0_r36
   48  ls
   49  clear
   50  mkdir -p ~/bin
   51  curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
   52  chmod a+x ~/bin/repo
   53  echo 'export PATH=~/bin:$PATH' >> ~/.bashrc
   54  source ~/.bashrc
   55  
   56  ls
   57  mkdir -p ~/bin
   58  curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
   
      
#    Clone AOSP Source Code.
   65  chmod a+x ~/bin/repo   
   66  repo init -u https://android.googlesource.com/platform/manifest -b android-15.0.0_r36
   67  repo sync -c -j$(nproc --all)
   
   
   # Save History in a file.
   68  history > ~/WORKSPACE/REPOS/history_out.txt
