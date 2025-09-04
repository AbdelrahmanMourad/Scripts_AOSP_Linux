#!/bin/bash

# git settings
git config --global user.email "abdelrahmanmourad.am@gmail.com"
git config --global user.name "Mourad"
 

# Create The Folder To Install Emulator inside.
cd ~
mkdir ~/emulator_qemu_vms/
cd emulator_qemu_vms/

# Install the emulator
sudo apt-get install qemu-system


############## Download the umage inside #####################
ls
#
# OUTPUT:
# 2017-04-10-raspbian-jessie.zip
#

# UnZip the File.
unzip 2017-04-10-raspbian-jessie.zip

# Start running the output.
fdisk -l 2017-04-10-raspbian-jessie.img
#
# OUTPUT:
# Disk 2017-04-10-raspbian-jessie.img: 3.99 GiB, 4285005824 bytes, 8369152 sectors
# Units: sectors of 1 * 512 = 512 bytes
# Sector size (logical/physical): 512 bytes / 512 bytes
# I/O size (minimum/optimal): 512 bytes / 512 bytes
# Disklabel type: dos
# Disk identifier: 0x402e4a57
#
# Device                          Boot Start     End Sectors  Size Id Type
# 2017-04-10-raspbian-jessie.img1       8192   92159   83968   41M  c W95 FAT32 (LBA)
# 2017-04-10-raspbian-jessie.img2      92160 8369151 8276992  3.9G 83 Linux
#

sudo mkdir /mnt/raspbian
#
# Offset is calculated from exported data as follows:
# Sector Size x Boot start = offset(Bytes)
# 512 x 92160 = 47185920
#

sudo mount -v -o offset=47185920 -t ext4\
 ~/emulator_qemu_vms/2017-04-10-raspbian-jessie.img /mnt/raspbian/

# Change directory to the installation file.
cd emulator_qemu_vms/

qemu-system-arm\
  -kernel ~/emulator_qemu_vms/kernel-qemu-4.4.34-jessie \ #Emulator File.
  -cpu arm1176 \                                                                                       
  -m 256 \                                    
  -M versatilepb \
  -serial stdio \
  -append "root=/dev/sda2 rootfstype=ext4 rw" \
  -hda ~/emulator_qemu_vms/2017-04-10-raspbian-jessie.img \ #Kernel Img.
  -net nic \
  -net user,hostfwd=tcp::5022-:22 \
  -no-reboot
