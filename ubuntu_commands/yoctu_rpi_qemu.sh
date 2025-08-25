#!/bin/bash


 mkdir YOCTO
 cd YOCTO/
 git clone https://git.yoctoproject.org/git/poky
 ls
 cd poky/
 source oe-init-build-env build-rpi
 code .
