#!/bin/bash
# Shebang

# =========================================================================================================
# Install chrome-browser on Linux:
# ===============================
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
google-chrome

# =========================================================================================================
# Install brave-browser on Linux:
# ===============================
# install in one line:
# curl -fsS https://dl.brave.com/install.sh | shs
# or install in multiple lines:
sudo apt install curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources
sudo apt update
sudo apt install brave-browser
brave-browser

# =========================================================================================================
# Install Rpi-Imager on Linux:
# ============================
sudo apt install rpi-imager


# =========================================================================================================
# Install VS-Code on Linux:
# =========================
sudo snap install code --classic

# =========================================================================================================
# Install obs-studio for Linux:
# =============================
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt install obs-studio
obs-studio

# =========================================================================================================
# Install Useful Commands on Linux:
# ===============================
sudo apt install htop




