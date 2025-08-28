#!/bin/bash

echo "=============================================================="
echo "  🚀 Build AOSP - Conservative Memory Settings"
echo "=============================================================="
echo ""

cd /media/abdullah/aosp/aosp16

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

print_status() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

print_status $BLUE "🔍 Building AOSP with conservative memory settings"
print_status $YELLOW "📋 Using aosp_cf_x86_64_only_phone-aosp_current-userdebug"

# Setup environment
print_status $BLUE "🔧 Setting up build environment..."
export USE_CCACHE=1
export CCACHE_DIR=/media/abdullah/aosp/aosp16/.ccache
export TMPDIR=/media/abdullah/aosp/aosp16/tmp
export TEMP=$TMPDIR
export TMP=$TMPDIR

# Create directories
mkdir -p $TMPDIR
mkdir -p $CCACHE_DIR

# Configure ccache - MUCH SMALLER to prevent memory issues
ccache -M 4G

# Source environment
print_status $BLUE "🔄 Sourcing AOSP environment..."
source build/envsetup.sh

# Use the correct format from documentation
print_status $BLUE "🎯 Setting target with correct format..."
lunch aosp_cf_x86_64_only_phone-aosp_current-userdebug

print_status $GREEN "🎯 Target: $TARGET_PRODUCT-$TARGET_BUILD_VARIANT"

# Check available memory
AVAILABLE_RAM=$(free -m | awk 'NR==2{print $7}')
print_status $BLUE "💾 Available Memory: ${AVAILABLE_RAM}MB"

# MUCH MORE CONSERVATIVE job settings to prevent crashes
if [ $AVAILABLE_RAM -gt 12000 ]; then
    JOBS=1
    print_status $GREEN "✅ High memory - Using 1 job (conservative to prevent crashes)"
elif [ $AVAILABLE_RAM -gt 8000 ]; then
    JOBS=1
    print_status $YELLOW "⚠️  Moderate memory - Using 1 job (safe)"
else
    JOBS=1
    print_status $RED "⚠️  Low memory - Using 1 job (very safe)"
fi

print_status $YELLOW "🚨 CRASH PREVENTION: Using single-threaded build to avoid memory overflow"

# Start build
print_status $GREEN "🚀 Starting AOSP build with crash prevention..."
echo "Build started at: $(date)" > aosp_correct_build.log
echo "Target: $TARGET_PRODUCT-$TARGET_BUILD_VARIANT" >> aosp_correct_build.log
echo "Jobs: $JOBS (conservative)" >> aosp_correct_build.log
echo "Ccache: 4GB (reduced)" >> aosp_correct_build.log
echo "===========================================" >> aosp_correct_build.log

# Execute build with conservative settings
if m -j$JOBS 2>&1 | tee -a aosp_correct_build.log; then
    print_status $GREEN "✅ AOSP build completed successfully!"
    
    echo ""
    print_status $BLUE "📦 Build outputs:"
    find out/target/product -name "*.img" 2>/dev/null | head -10 || echo "No image files found"
    
    echo ""
    print_status $GREEN "🎉 AOSP is ready!"
    print_status $BLUE "Next steps:"
    echo "1. Check build outputs: ls -la out/target/product/vsoc_x86_64_only/"
    echo "2. You can now use these images with Cuttlefish"
    
else
    print_status $RED "❌ Build failed!"
    print_status $YELLOW "Check aosp_correct_build.log for errors"
fi

echo ""
print_status $BLUE "🏁 Build process completed at: $(date)" 
