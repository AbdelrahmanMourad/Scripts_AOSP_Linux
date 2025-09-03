#!/bin/bash

# ======================================================================================================================
# Aliases setup script
# This script installs useful aliases into ~/.bashrc permanently.
# Run it once after a fresh Ubuntu installation.
# ======================================================================================================================

# Define the target config file (your bash shell configuration file)
CONFIG_FILE="$HOME/.bashrc"

# Define the aliases block that we want to add permanently into .bashrc
# Using a HEREDOC to keep everything formatted nicely
ALIASES=$(cat <<'EOF'
# ======================================================================================================================
# Custom Aliases: shortcuts to ease my work
# ======================================================================================================================
alias cls='clear'             # Clear the terminal screen
alias ll='ls -la'             # List all files with detailed information
alias ..='cd ..'              # Move up one directory
alias ...='cd ../..'          # Move up two directories
alias open='xdg-open .'       # Open files/folders in GUI from terminal

# Git shortcuts
# alias gs='git status'       # Check the status of a Git repository
# alias ga='git add .'        # Stage all changes for commit
# alias gc='git commit -m'    # Commit staged changes with a message
# alias gp='git push'         # Push commits to the remote repository
# alias gl='git log --oneline --graph --decorate' # Concise Git log

# Misc shortcuts
# alias h='history'           # Show command history
# alias j='jobs -l'           # List all current jobs with their process IDs
# alias psg='ps aux | grep'   # Search for processes by name
# alias df='df -h'            # Display disk space usage
# alias du='du -h --max-depth=1' # Show disk usage of directories with depth 1
# alias free='free -h'        # Display memory usage
# alias mkdir='mkdir -p'      # Create directories, including parents
# alias wget='wget -c'        # Continue downloading partially downloaded files

# AOSP navigation
# alias aosp13='cd ~/aosp13'
# alias aosp14='cd ~/aosp14'
# alias aosp15='cd ~/aosp15'
# alias rpi5='cd ~/aosp_rpi5'

# Extra helpers
# alias llr='ls -laR'         # Recursive ls
# alias path='echo -e ${PATH//:/\\n}' # Display PATH line by line
# alias ip='ip addr show'     # Show IP addresses
EOF
)

# ------------------------------------------------------------------------------------
echo "======================================================================"
echo "[STEP 1] Checking if aliases are already in $CONFIG_FILE ..."
# ------------------------------------------------------------------------------------

# Check if our aliases block already exists (so we don’t duplicate it every time)
if grep -q "Custom Aliases: shortcuts to ease my work" "$CONFIG_FILE"; then
    echo "[INFO] Aliases already exist in $CONFIG_FILE ✅"
else
    echo "[INFO] Aliases not found, adding them now ..."
    # Append a new line before the block for clarity
    echo "" >> "$CONFIG_FILE"
    # Append the aliases block into .bashrc
    echo "$ALIASES" >> "$CONFIG_FILE"
    echo "[INFO] Aliases block added successfully ✅"
fi

# ------------------------------------------------------------------------------------
echo "======================================================================"
echo "[STEP 2] Reloading $CONFIG_FILE so aliases are active immediately ..."
# ------------------------------------------------------------------------------------

# Reload .bashrc so you don’t need to log out/in
# shellcheck disable=SC1090
source "$CONFIG_FILE"

# ------------------------------------------------------------------------------------
echo "======================================================================"
echo "[STEP 3] Done 🎉 Try using your aliases now:"
echo "         - ll   → list all files"
echo "         - cls  → clear screen"
echo "         - open . → open current folder in GUI"
echo "======================================================================"
