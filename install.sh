#!/bin/bash

# Install git and Visual Studio Code
sudo snap install git 
sudo snap install code

# Create a temporary directory and set up a trap for cleaning up
Time_Stamp=$(date +%Y%m%d%H%M%S)
Tmp_Dir=$(mktemp -dt "install.$Time_Stamp.XXXXXXXXXX")
trap 'rm -rf "$Tmp_Dir"' EXIT

# Remove existing Microsoft GPG key and Edge list if they exist
[ -f "/usr/share/keyrings/microsoft.gpg" ] && rm -f "/usr/share/keyrings/microsoft.gpg"
[ -f "/etc/apt/sources.list.d/microsoft-edge.list" ] && rm -f "/etc/apt/sources.list.d/microsoft-edge.list"

# Download Microsoft GPG key and add to the system
wget -qO- --user-agent="Mozilla/5.0 Gecko/20100101" --timeout=30 "https://packages.microsoft.com/keys/microsoft.asc" | gpg --dearmor --yes --quiet -o "/usr/share/keyrings/microsoft.gpg"

# Add Microsoft Edge to the sources list
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge.list

# Update and install Microsoft Edge
sudo apt-get --yes update
sudo apt-get --yes install microsoft-edge-stable

# Install additional utilities
sudo apt install ubuntu-restricted-extras ttf-mscorefonts-installer
sudo apt install gnome-tweaks
sudo apt install guvcview
sudo apt install git software-properties-common -y
sudo add-apt-repository ppa:gerardpuig/ppa
sudo apt update -y
sudo apt install ubuntu-cleaner

# Install NVM and latest Node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
source ~/.bashrc
nvm install latest

# Install GNOME shell extensions
sudo apt install gnome-shell-extensions

# Install OpenJDK and Android Studio
sudo apt install openjdk-11-jre-headless 
sudo add-apt-repository ppa:maarten-fonville/android-studio
sudo apt update
sudo apt install android-studio
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Install Oh My Posh
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/bin
echo 'eval "$(oh-my-posh init bash --config ~/ohmyposh.omp.json)"' >> ~/.bashrc

# Install JetBrains Mono font
cd ~/
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono
sudo cp JetBrainsMono/*.ttf /usr/local/share/fonts/
sudo fc-cache -fv
rm -rf JetBrainsMono

# Install VIM
sudo apt install vim

# Install Graphite GTK theme
git clone https://github.com/vinceliuice/Graphite-gtk-theme.git
cd Graphite-gtk-theme
./install.sh --tweaks rimless darker
cd ..
rm -rf Graphite-gtk-theme

# Wait for user input to close the script
echo -e "\nInstallation complete. Press any key to exit."
read -rsp $'' -n1
