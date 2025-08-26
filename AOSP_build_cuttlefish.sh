#!/bin/bash
# The shebang (#!) at the top tells the system to use the Bash shell to interpret this script.
# It ensures your script runs with the correct shell, regardless of the user's default shell.
# This is important for compatibility and to avoid unexpected behavior if the script uses Bash-specific features.
# Always place the shebang as the very first line in your script.

#############################################
# Build AOSP for Cuttlefish
#############################################
source build/envsetup.sh
ls
cd
cd ~/WORKSPACE/AOSP_15.0.0_36/
source build/envsetup.sh
lunch aosp_cf_x86_64_auto-trunk_staging-userdebug
source build/envsetup.sh
lunch aosp_cf_x86_64_auto-trunk_staging-userdebug
repo sync -j$(nproc)
hmm
m



#############################################
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
