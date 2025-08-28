~!/bin/bash


# ==================================================================
# Change output directory for AOSP build for RPi5 Android_15.0.0_36
# =================================================================
export OUT_DIR=/home/abdullah/aosp13/aosp/out_cf
#
source build/envsetup.sh
lunch aosp_cf_x86_64_auto-ap2a-userdebug
build_build_var_cache
lunch