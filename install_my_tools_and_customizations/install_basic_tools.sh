#!/bin/bash
# Shebang

# =========================================================================================================
# Install Browsers on Linux:
# =========================================================================================================
#
echo "======================="
echo "Install chrome-browser:"
echo "======================="
#
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
google-chrome
#
#
echo "======================"
echo "Install brave-browser:"
echo "======================"
#
# install in one line:
# curl -fsS https://dl.brave.com/install.sh | shs
# or install in multiple lines:
#
sudo apt install curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources
sudo apt update
sudo apt install brave-browser
brave-browser
#
#


# =========================================================================================================
# Install Rpi-related Tools on Linux:
# =========================================================================================================
#
echo "==================="
echo "Install Rpi-Imager:"
echo "==================="
#
sudo apt install rpi-imager
#
#


# =========================================================================================================
# Install IDEs' on Linux:
# =========================================================================================================
#
echo "===================="
echo "Install VS-Code IDE:"
echo "===================="
#
sudo snap install code --classic
#
#


# =========================================================================================================
# Install obs-studio for Linux:
# =========================================================================================================
echo "================================================="
echo "Install 'obs-studio' for Recodring and Streaming:"
echo "================================================="
#
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt install obs-studio
obs-studio
#
#


# =========================================================================================================
# Install Media-Players for Linux:
# =========================================================================================================
echo "==========================="
echo "Install 'vlc' Media Player"
echo "==========================="
#
sudo snap install vlc
#
#


# =========================================================================================================
# Install Useful Commands on Linux:
# =========================================================================================================
echo "==========================="
echo "Install important commands:"
echo "==========================="
#
sudo apt install htop
#
#



