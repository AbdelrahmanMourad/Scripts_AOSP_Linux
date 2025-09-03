#!/bin/bash
#
# AOSP Repo Clean & Resync Script
# --------------------------------------
# This script resets all git repos in your AOSP workspace,
# removes untracked files, and re-syncs with the manifest.
#
# ⚠️ WARNING:
#   - This will delete ALL local changes and untracked files.
#   - Make sure you don’t have work you want to keep before running.
#

# ========================
# CONFIGURATION
# ========================
WORKSPACE_DIR=~/WORKSPACE/AOSP_13.0.0_r84   # <-- Change this to your AOSP workspace path
BRANCH=android-13.0.0_r84                   # <-- Change this to your desired branch

# ========================
# SCRIPT START
# ========================

echo "======================================"
echo "   AOSP Clean & Repo Sync Script"
echo "   Workspace: $WORKSPACE_DIR"
echo "   Branch:    $BRANCH"
echo "======================================"
echo

# Step 1: Go to workspace
echo "[1/5] Changing directory to workspace..."
cd "$WORKSPACE_DIR" || { echo "❌ ERROR: Workspace not found!"; exit 1; }
echo "✅ Entered $WORKSPACE_DIR"
echo

# Step 2: Reset all repos (discard local changes)
echo "[2/5] Resetting all git repos (discarding changes)..."
repo forall -c 'echo " → Resetting $REPO_PATH"; git reset --hard'
echo "✅ All repos reset"
echo

# Step 3: Remove untracked files (like mgsi_*.mk etc.)
echo "[3/5] Cleaning untracked files and directories..."
repo forall -c 'echo " → Cleaning $REPO_PATH"; git clean -fdx'
echo "✅ All repos cleaned"
echo

# Step 4: Re-init manifest to the correct branch
echo "[4/5] Re-initializing repo to branch: $BRANCH"
repo init -u https://android.googlesource.com/platform/manifest -b $BRANCH --force-sync
if [ $? -ne 0 ]; then
  echo "❌ ERROR: repo init failed"
  exit 1
fi
echo "✅ Repo re-initialized to $BRANCH"
echo

# Step 5: Sync repos
echo "[5/5] Syncing repos... this may take a while ⏳"
repo sync -c -j$(nproc --all) --force-sync
if [ $? -ne 0 ]; then
  echo "❌ ERROR: repo sync failed"
  exit 1
fi
echo "✅ Repo sync complete!"
echo

echo "========================================"
echo "  🎉 AOSP $BRANCH is now clean & synced!"
echo "========================================"
