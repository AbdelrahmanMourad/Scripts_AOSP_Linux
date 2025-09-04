    1  sudo apt update
    2  sudo apt install open-vm-tools-desktop -y 
    3  sudo reboot
    4  --versionls
    5  -version
    6  versoi
    7  versoin
    8  version
    9  -version
   10  --version
   11  ubuntu --version
   12  clear
   13  pwd
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
   58  sudo apt-get install qemu-system
   59  ls
   60  ls
   61  sudo apt install python
   62  sudo apt install python3
   63  sudo apt install gcc
   64  ls
   65  history
   66  cd ~
   67  ls
   68  cd android-automotive/
   69  ls
   70  cd out
   71  ls
   72  cd soong/
   73  ls
   74  pwd
   75  cd ..
   76  pwd
   77  ls
   78  cd ~
   79  cd
   80  cd /
   81  cd \
   82  ls
   83  clear
   84  cd 
   85  mkdir ~/emulator_qemu_vms/
   86  ls
   87  cd emulator_qemu_vms/
   88  sudp apt-get install qemu-system
   89  sudo apt-get install qemu-system
   90  ls
   91  unzip <image-file>.zip
   92  ls
   93  unzip 2017-04-10-raspbian-jessie.zip 
   94  ls
   95  fdisk -l 2017-04-10-raspbian-jessie.img 
   96  mkdir /mnt/raspbian
   97  cd /mnt/
   98  ls
   99  sudo mkdir /mnt/raspbian
  100  ls
  101  sudo mount -v -o offset=47185920 -t ext4 ~/emulator_qemu_vms/2017-04-10-raspbian-jessie.img /mnt/raspbian/
  102  sudo nano /mnt/raspbian/etc/ld.so.preload 
  103  sudo nano /mnt/raspbian/etc/fstab 
  104  cd ~
  105  sudo unount /mnt/raspbian/
  106  sudo unmount /mnt/raspbian/
  107  sudo umount /mnt/raspbian/
  108  qemu-system-arm -kernel ~/emulator_qemu_vms/2017-04-10-raspbian-jessie.img -cpu arm1176 -m 256 -M versatilepb -serial stdio -append "root=/dev/sda2 rootfstype=ext4 rw" -hda ~/emulator_qemu_vms/2017-04-10-raspbian-jessie.img -redur tcp:5022::22 -no-reboot
  109  qemu-system-arm -kernel ~/emulator_qemu_vms/2017-04-10-raspbian-jessie.img -cpu arm1176 -m 256 -M versatilepb -serial stdio -append "root=/dev/sda2 rootfstype=ext4 rw" -hda ~/emulator_qemu_vms/2017-04-10-raspbian-jessie.img -redir tcp:5022::22 -no-reboot
  110  qemu-system-arm -kernel ~/emulator_qemu_vms/2017-04-10-raspbian-jessie.img -cpu arm1176 -m 256 -M versatilepb -serial stdio -append "root=/dev/sda2 rootfstype=ext4 rw" -hda ~/emulator_qemu_vms/2017-04-10-raspbian-jessie.img -net user, hostfwd=tcp:5022::22 -no-reboot
  111  cd 
  112  cd emulator_qemu_vms/
  113  ls
  114  qemu-system-arm   -kernel ~/emulator_qemu_vms/kernel-qemu-4.4.34-jessie   -cpu arm1176   -m 256   -M versatilepb   -serial stdio   -append "root=/dev/sda2 rootfstype=ext4 rw"   -hda ~/emulator_qemu_vms/2017-04-10-raspbian-jessie.img   -net nic   -net user,hostfwd=tcp::5022-:22   -no-reboot
  115  qemu-system-arm   -kernel ~/emulator_qemu_vms/kernel-qemu-4.4.34-jessie   -cpu arm1176   -m 256   -M versatilepb   -serial stdio   -append "root=/dev/sda2 rootfstype=ext4 rw"   -hda ~/emulator_qemu_vms/2017-04-10-raspbian-jessie.img   -net nic   -net user,hostfwd=tcp::5022-:22   -no-reboot
  116  history
