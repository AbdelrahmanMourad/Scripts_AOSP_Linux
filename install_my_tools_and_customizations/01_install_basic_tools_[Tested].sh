#!/bin/bash
# Shebang


#
# =============================================================================
# Script: 01_install_basic_tools.sh
# Purpose: Install essential tools, browsers, office suites, and media players
#          on Ubuntu Linux with clear terminal output and robust dependency handling.
# =============================================================================
#


# =========================================================================================================
# 1. Updating system and installing core dependencies:
# =========================================================================================================
#
echo "=============================================================="
echo "=== 1. Updating system and installing core dependencies... ==="
echo "=============================================================="

# Update package list and install core dependencies required for later steps
sudo apt update -y
sudo apt install -y snapd curl wget software-properties-common apt-transport-https ca-certificates gnupg lsb-release





# =========================================================================================================
# 2. Install Browsers:
# =========================================================================================================
#
echo
echo "===================================="
echo "=== 2. Installing Browsers...    ==="
echo "===================================="

# -----------------------------------------------------
# Google Chrome (Fast, popular browser from Google)
#   - Good for web development and general browsing.
# -----------------------------------------------------
echo "[INFO] Installing Google Chrome..."
wget -O /tmp/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i /tmp/google-chrome.deb || sudo apt install -f -y
rm /tmp/google-chrome.deb
# google-chrome #open

# -----------------------------------------------------
# Brave Browser (Privacy-focused browser)
#   - Built-in ad blocker and privacy features.
# -----------------------------------------------------
echo "[INFO] Installing Brave Browser..."
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update -y
sudo apt install -y brave-browser
# brave-browser #open




# =========================================================================================================
# 3. Install IDEs (Integrated Development Environments):
# =========================================================================================================
#
echo
echo "===================================="
echo "=== 3. Installing IDEs...        ==="
echo "===================================="

# -----------------------------------------------------
# Visual Studio Code (Popular code editor by Microsoft)
#   - Supports many languages and extensions.
# -----------------------------------------------------
sudo snap install code --classic







# =========================================================================================================
# 4. Install Rpi Tools
# =========================================================================================================
#
echo
echo "===================================="
echo "=== 4. Installing RPi Tools...   ==="
echo "===================================="

# -----------------------------------------------------
# RPi Imager (Official Raspberry Pi SD card writing tool)
#   - Used to flash OS images to SD cards for Raspberry Pi.
# -----------------------------------------------------
echo "[INFO] Installing Raspberry Pi Imager..."
sudo apt install -y rpi-imager

# -----------------------------------------------------
# Additional RPi utilities (optional, uncomment as needed)
#   - piclone: SD card copier for Raspberry Pi (if available)
#   - raspi-config: Raspberry Pi configuration tool (if available)
# -----------------------------------------------------
# sudo apt install -y piclone raspi-config





# =========================================================================================================
# 5. Install OBS Studio for Linux:
# =========================================================================================================
#
echo
echo "===================================="
echo "=== 5. Installing OBS Studio...  ==="
echo "===================================="

# -----------------------------------------------------
# OBS Studio (Open Broadcaster Software)
#   - For screen recording and live streaming.
# -----------------------------------------------------
sudo add-apt-repository -y ppa:obsproject/obs-studio
sudo apt update -y
sudo apt install -y obs-studio
# obs-studio #open






# =========================================================================================================
# 6. Install Media-Players:
# =========================================================================================================
#
echo
echo "====================================="
echo "=== 6. Installing Media Players... =="
echo "====================================="

# -----------------------------------------------------
# VLC Media Player (Versatile media player)
#   - Plays almost any audio/video format.
# -----------------------------------------------------
echo "[INFO] Installing VLC Media Player..."
sudo snap install vlc

# -----------------------------------------------------
# SMPlayer (Front-end for MPlayer, supports YouTube, subtitles, etc.)
#   - DMPlayer is a typo; SMPlayer is the correct package.
# -----------------------------------------------------
echo "[INFO] Installing SMPlayer..."
sudo add-apt-repository -y ppa:rvm/smplayer 
sudo apt update -y
sudo apt install -y smplayer smplayer-themes smplayer-skins





# =========================================================================================================
# 7. Install Utilities (Useful Commands):
# =========================================================================================================
#
echo
echo "==============================================="
echo "=== 7. Installing Utilities (commands)...   ==="
echo "==============================================="

# -----------------------------------------------------
# htop (Interactive process viewer)
#   - Better than 'top' for monitoring system resources.
# -----------------------------------------------------
sudo apt install -y htop

# -----------------------------------------------------
# Additional useful terminal tools
#   - git: Version control system
#   - tmux: Terminal multiplexer
#   - tree: Directory tree viewer
#   - neofetch: System info summary
#   - unzip: Extract zip files
#   - net-tools: Networking utilities (ifconfig, etc.)
#   - build-essential: Compiler and build tools
# -----------------------------------------------------
sudo apt install -y git tmux tree neofetch unzip net-tools build-essential



# =========================================================================================================
# 8. Install install_office_tools
#       This script part installs LibreOffice, OnlyOffice, and WPS Office on Ubuntu.
# =========================================================================================================
#
echo
echo "===================================="
echo "=== 8. Installing Office Suites  ==="
echo "===================================="

# -----------------------------------------------------
# LibreOffice (Default, free, and most popular on Ubuntu)
#   - Writer (Word), Calc (Excel), Impress (PowerPoint).
#   - Opens and edits .docx, .xlsx, .pptx files.
# -----------------------------------------------------
echo "[INFO] Installing LibreOffice..."
sudo apt install -y libreoffice

# -----------------------------------------------------
# OnlyOffice (Modern MS Office-like suite)
#   - Best compatibility with .docx/.xlsx/.pptx files.
# -----------------------------------------------------
echo "[INFO] Installing OnlyOffice..."
sudo apt install -y onlyoffice-desktopeditors

# -----------------------------------------------------
# WPS Office (Free alternative to MS Office)
#   - Excellent Arabic support, handles .docx/.xlsx/.pptx well.
# -----------------------------------------------------
echo "[INFO] Downloading WPS Office .deb package..."
wget -O /tmp/wps-office.deb https://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/11702/wps-office_11.1.0.11702.XA_amd64.deb
echo "[INFO] Installing WPS Office..."
sudo apt install -y /tmp/wps-office.deb

# -----------------------------------------------------
# Clean up temporary files
# -----------------------------------------------------
echo "[INFO] Cleaning up..."
rm /tmp/wps-office.deb

# Optional: Clean up unused packages and apt cache
sudo apt autoremove -y
sudo apt clean



# =========================================================================================================
# End of Script
# =========================================================================================================
#
echo
echo "===================================="
echo "=== All installations complete!  ==="
echo "===================================="
#






# =========================================================================================================
# NOTES:
# =========================================================================================================
# The "-y" option in commands like: 
#     - ("apt install -y") or 
#     - ("apt update -y")
#   |------------------------------------------------|
#   |{{{{   means "assume yes" to all prompts.   }}}}|
#   |------------------------------------------------|
# It is used to automatically answer "yes" to any confirmation questions during installation or updates, 
#   so the process runs non-interactively (without stopping to ask the user for input). 
# This is especially useful in scripts to ensure smooth, unattended execution.
# =========================================================================================================
