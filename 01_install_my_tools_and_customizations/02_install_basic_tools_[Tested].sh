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
# Developer Environment Setup Script (Ubuntu 24.04+)
# Prepares auto-formatters for:
#   - C++   (clang-format)
#   - Python (black)
#   - Bash  (shfmt)
#   - Java  (google-java-format)
#   - Kotlin (ktlint)
# Also auto-configures VS Code settings.json and installs extensions
# -----------------------------------------------------

set -e  # Exit immediately on error

# ---------------------- [1/5] System Update --------------------------
echo "[1/5] Updating system packages..."
sudo apt update && sudo apt upgrade -y
echo "[1/5] ✅ System update complete."
echo

# ---------------------- [2/5] Install Formatters ----------------------
echo "[2/5] Installing code formatters..."

# --- C++ ---
echo "  -> Installing clang-format (C++)..."
sudo apt install -y clang-format

# --- Python ---
echo "  -> Installing black (Python)..."
sudo apt install -y python3-black

# --- Bash ---
echo "  -> Installing shfmt (Bash)..."
sudo apt install -y shfmt

# --- Java ---
echo "  -> Installing google-java-format (Java)..."
sudo apt install -y google-java-format

# --- Kotlin ---
echo "  -> Installing ktlint (Kotlin)..."
sudo apt install -y default-jre unzip
curl -sSLO https://github.com/pinterest/ktlint/releases/download/1.3.1/ktlint-1.3.1.zip
unzip -o ktlint-1.3.1.zip -d ~/.local/bin/
chmod +x ~/.local/bin/ktlint
rm ktlint-1.3.1.zip

echo "[2/5] ✅ Formatter installation complete."
echo

# ---------------------- [3/5] Verify Installation ---------------------
echo "[3/5] Verifying formatter versions..."

echo -n "clang-format: "; clang-format --version || echo "❌ Missing"
echo -n "black: "; black --version || echo "❌ Missing"
echo -n "shfmt: "; shfmt --version || echo "❌ Missing"
echo -n "google-java-format: "; google-java-format --version || echo "❌ Missing"
echo -n "ktlint: "; ktlint --version || echo "❌ Missing"

echo "[3/5] ✅ Verification complete."
echo

# ---------------------- [4/5] Configure VS Code -----------------------
echo "[4/5] Updating VS Code settings.json and installing extensions..."

# Ensure VS Code config directory exists
VSCODE_SETTINGS_DIR="$HOME/.config/Code/User"
VSCODE_SETTINGS_FILE="$VSCODE_SETTINGS_DIR/settings.json"
mkdir -p "$VSCODE_SETTINGS_DIR"

# Install VS Code if missing
if ! command -v code &> /dev/null; then
    echo "  -> VS Code not found, installing..."
    sudo snap install code --classic
fi

# Install required extensions
echo "  -> Installing VS Code extensions..."
code --install-extension xaver.clang-format --force
code --install-extension ms-python.black-formatter --force
code --install-extension foxundermoon.shell-format --force
code --install-extension google.google-java-format --force
code --install-extension fwcd.kotlin --force

# Create or update settings.json with formatter configs
cat > "$VSCODE_SETTINGS_FILE" <<EOF
{
    // Auto-format on save
    "editor.formatOnSave": true,

    // Formatter associations
    "[cpp]": {
        "editor.defaultFormatter": "xaver.clang-format"
    },
    "[c]": {
        "editor.defaultFormatter": "xaver.clang-format"
    },
    "[python]": {
        "editor.defaultFormatter": "ms-python.black-formatter"
    },
    "[shellscript]": {
        "editor.defaultFormatter": "foxundermoon.shell-format"
    },
    "[java]": {
        "editor.defaultFormatter": "google.google-java-format"
    },
    "[kotlin]": {
        "editor.defaultFormatter": "fwcd.kotlin"
    }
}
EOF

echo "[4/5] ✅ VS Code configured."
echo "       Formatters + extensions ready for Shift+Alt+F"
echo "       Settings file: $VSCODE_SETTINGS_FILE"
echo

# ---------------------- [5/5] Completion ------------------------------
echo "[5/5] ✅ Setup complete!"
echo "Restart VS Code if it was already open."
echo "Now you can use (Shift + Alt + F) to auto-format:"
echo "   - C++ with clang-format"
echo "   - Python with black"
echo "   - Bash with shfmt"
echo "   - Java with google-java-format"
echo "   - Kotlin with ktlint"
echo "====================================================================="





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
