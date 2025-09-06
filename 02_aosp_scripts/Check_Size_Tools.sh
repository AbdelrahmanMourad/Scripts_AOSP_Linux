# #!/bin/bash
# # =====================================================================
# # Disk Usage Report Script
# # Author: Mourad
# # =====================================================================

# # Output file
# REPORT_FILE=~/disk_usage_report.txt

# echo "======================================================" > $REPORT_FILE
# echo " DISK USAGE REPORT - $(date)" >> $REPORT_FILE
# echo "======================================================" >> $REPORT_FILE
# echo "" >> $REPORT_FILE

# # --------------------------
# # 1. Disk overview
# # --------------------------
# echo ">>> Disk Overview (df -h)" | tee -a $REPORT_FILE
# df -h | tee -a $REPORT_FILE
# echo "" >> $REPORT_FILE

# # --------------------------
# # 2. Home directory usage
# # --------------------------
# echo ">>> Folder sizes inside HOME (~)" | tee -a $REPORT_FILE
# du -sh ~/* ~/.[!.]* 2>/dev/null | sort -h | tee -a $REPORT_FILE
# echo "" >> $REPORT_FILE

# # --------------------------
# # 3. Workspace usage
# # --------------------------
# if [ -d ~/WORKSPACE ]; then
#   echo ">>> Folder sizes inside WORKSPACE" | tee -a $REPORT_FILE
#   du -sh ~/WORKSPACE/* ~/WORKSPACE/.[!.]* 2>/dev/null | sort -h | tee -a $REPORT_FILE
#   echo "" >> $REPORT_FILE
# fi

# # --------------------------
# # 4. External drive usage
# # --------------------------
# if [ -d "/media/$USER/Mourad 1" ]; then
#   echo ">>> Folder sizes inside External Drive (Mourad 1)" | tee -a $REPORT_FILE
#   du -sh "/media/$USER/Mourad 1"/* "/media/$USER/Mourad 1"/.[!.]* 2>/dev/null | sort -h | tee -a $REPORT_FILE
#   echo "" >> $REPORT_FILE
# fi

# echo "======================================================" >> $REPORT_FILE
# echo " Report saved to: $REPORT_FILE"
# echo "======================================================"

# # Also show path to user
# cat $REPORT_FILE




# Just run this and navigate through the directories.
sudo apt install ncdu -y
ncdu /
# ncdu ~/WORKSPACE

