#!/bin/bash
#
# AOSP Deep Clean & Fresh Download Script
# ---------------------------------------
# This script will:
#   1. Delete the entire AOSP workspace directory (⚠️ irreversible!)
#   2. Recreate the directory
#   3. Repo init with the chosen branch
#   4. Repo sync to download everything from scratch
#
# ⚠️ WARNING:
#   - This will ERASE all files in the workspace folder.
#   - Make sure you don’t have anything important inside before running.
#

# ========================
# CONFIGURATION
# ========================
WORKSPACE_DIR=~/WORKSPACE/AOSP_13.0.0_r84  # <-- Change this to your AOSP workspace path
BRANCH=android-13.0.0_r84                  # <-- Change this to your desired branch

# ========================
# SCRIPT START
# ========================

echo "======================================"
echo "   AOSP Deep Clean & Fresh Download"
echo "   Workspace: $WORKSPACE_DIR"
echo "   Branch:    $BRANCH"
echo "======================================"
echo

# Step 1: Confirm with user
read -p "⚠️ WARNING: This will delete $WORKSPACE_DIR completely. Continue? (y/N): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo "❌ Cancelled by user."
  exit 1
fi

# Step 2: Remove existing workspace
echo "[1/4] Deleting existing workspace: $WORKSPACE_DIR"
rm -rf "$WORKSPACE_DIR"
if [ $? -ne 0 ]; then
  echo "❌ ERROR: Failed to delete $WORKSPACE_DIR"
  exit 1
fi
echo "✅ Workspace deleted"
echo

# Step 3: Recreate clean workspace
echo "[2/4] Creating fresh workspace directory..."
mkdir -p "$WORKSPACE_DIR"
cd "$WORKSPACE_DIR" || { echo "❌ ERROR: Could not enter workspace"; exit 1; }
echo "✅ Workspace created at $WORKSPACE_DIR"
echo

# Step 4: Repo init with specified branch
echo "[3/4] Initializing repo with branch $BRANCH..."
repo init -u https://android.googlesource.com/platform/manifest -b $BRANCH
if [ $? -ne 0 ]; then
  echo "❌ ERROR: repo init failed"
  exit 1
fi
echo "✅ Repo initialized"
echo

# Step 5: Repo sync (download all source)
echo "[4/4] Syncing repos... this may take a long time ⏳"
repo sync -c -j$(nproc --all) --force-sync
if [ $? -ne 0 ]; then
  echo "❌ ERROR: repo sync failed"
  exit 1
fi
echo "✅ Repo sync complete!"
echo

echo "======================================"
echo "  🎉 Fresh AOSP $BRANCH is ready!"
echo "  Location: $WORKSPACE_DIR"
echo "======================================"
