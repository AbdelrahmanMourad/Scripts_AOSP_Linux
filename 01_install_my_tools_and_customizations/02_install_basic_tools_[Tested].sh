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
# 3. Install Programming Languages & Compilers:
#       This section installs compilers/interpreters for Python, C, C++, Java, and Kotlin.
# =========================================================================================================
#
echo
echo "=============================================================="
echo "=== 3. Installing Programming Languages & Compilers...     ==="
echo "=============================================================="

# -----------------------------------------------------
# Python (Interpreter for Python 3)
#   - Popular language for scripting, automation, and data science.
# -----------------------------------------------------
echo "[INFO] Installing Python 3 and pip..."
sudo apt install -y python3 python3-pip

# -----------------------------------------------------
# C and C++ (GNU Compiler Collection)
#   - gcc: C compiler
#   - g++: C++ compiler
# -----------------------------------------------------
echo "[INFO] Installing GCC (C) and G++ (C++) compilers..."
sudo apt install -y gcc g++

# -----------------------------------------------------
# Java (OpenJDK)
#   - openjdk-17-jdk: Java Development Kit (JDK) version 17
# -----------------------------------------------------
echo "[INFO] Installing OpenJDK (Java)..."
sudo apt install -y openjdk-17-jdk

# -----------------------------------------------------
# Kotlin (via Snap)
#   - Modern JVM language, interoperable with Java.
# -----------------------------------------------------
echo "[INFO] Installing Kotlin compiler..."
sudo snap install --classic kotlin




# =========================================================================================================
# 4. Install IDEs (Integrated Development Environments):
# =========================================================================================================
#
echo
echo "===================================="
echo "=== 4. Installing IDEs...        ==="
echo "===================================="

# -----------------------------------------------------
# Visual Studio Code (Popular code editor by Microsoft)
#   - Supports many languages and extensions.
# -----------------------------------------------------
echo "[INFO] Installing vs-code ide..."
sudo snap install code --classic

# -----------------------------------------------------
# setup_vscode_formatters.sh
# Purpose:
#   Automate setup of formatters in VS Code for C++, Python, Bash
#   so Shift+Alt+F works out of the box.
# -----------------------------------------------------
set -e

echo "=== [1/4] Installing required tools ==="
# Update system
sudo apt update -y

# Install clang-format for C++
sudo apt install -y clang-format

# Install Python + pip if missing
sudo apt install -y python3 python3-pip
pip3 install --upgrade pip

# Install Python formatter (black)
pip3 install black

# Install ShellCheck for linting shell scripts
sudo apt install -y shellcheck

# Install shfmt for shell formatting (requires Go)
if ! command -v go &>/dev/null; then
    echo "[INFO] Installing Go (needed for shfmt)..."
    sudo apt install -y golang
fi
go install mvdan.cc/sh/v3/cmd/shfmt@latest
export PATH=$PATH:$(go env GOPATH)/bin

echo "=== [2/4] Installing VS Code extensions ==="
code --install-extension ms-vscode.cpptools --force       # C++ support
code --install-extension ms-python.python --force         # Python support
code --install-extension foxundermoon.shell-format --force # Bash formatting
code --install-extension timonwong.shellcheck --force     # Bash linting

echo "=== [3/4] Updating VS Code user settings ==="
SETTINGS_DIR="$HOME/.config/Code/User"
SETTINGS_FILE="$SETTINGS_DIR/settings.json"

mkdir -p "$SETTINGS_DIR"

# Create settings.json with formatters
cat > "$SETTINGS_FILE" <<'EOF'
{
    // =============================
    // Auto-formatting configuration
    // =============================
    "[cpp]": {
        "editor.defaultFormatter": "ms-vscode.cpptools"
    },
    "[c]": {
        "editor.defaultFormatter": "ms-vscode.cpptools"
    },
    "[python]": {
        "editor.defaultFormatter": "ms-python.python"
    },
    "[shellscript]": {
        "editor.defaultFormatter": "foxundermoon.shell-format"
    },
    "python.formatting.provider": "black",
    "editor.formatOnSave": true,
    "editor.formatOnPaste": true
}
EOF

echo "=== [4/4] Done! ==="
echo "Formatters installed for C++, Python, and Bash."
echo "You can now press Shift+Alt+F in VS Code to format code."





# =========================================================================================================
# 5. Install Rpi Tools
# =========================================================================================================
#
echo
echo "===================================="
echo "=== 5. Installing RPi Tools...   ==="
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
# 6. Install OBS Studio for Linux:
# =========================================================================================================
#
echo
echo "===================================="
echo "=== 6. Installing OBS Studio...  ==="
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
# 7. Install Media-Players:
# =========================================================================================================
#
echo
echo "====================================="
echo "=== 7. Installing Media Players... =="
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
# 8. Install Utilities (Useful Commands):
# =========================================================================================================
#
echo
echo "==============================================="
echo "=== 8. Installing Utilities (commands)...   ==="
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
# 9. Install install_office_tools
#       This script part installs LibreOffice, OnlyOffice, and WPS Office on Ubuntu.
# =========================================================================================================
#
echo
echo "===================================="
echo "=== 9. Installing Office Suites  ==="
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
