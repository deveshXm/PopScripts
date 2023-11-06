#!/bin/bash

# Create a temporary directory and set up a trap for cleaning up
Time_Stamp=$(date +%Y%m%d%H%M%S)
Tmp_Dir=$(mktemp -dt "install.$Time_Stamp.XXXXXXXXXX")
trap 'rm -rf "$Tmp_Dir"' EXIT

# Update package lists
sudo apt-get update

# Install essential packages
sudo apt-get install -y curl wget git software-properties-common vim ca-certificates gnupg

# Install NeoFetch
sudo apt-get install -y neofetch

# Install Visual Studio Code
sudo apt-get install -y code

# Download and install JetBrains Mono font
wget -qO $Tmp_Dir/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip $Tmp_Dir/JetBrainsMono.zip -d $Tmp_Dir/JetBrainsMono
sudo cp $Tmp_Dir/JetBrainsMono/*.ttf /usr/local/share/fonts/
sudo fc-cache -fv

# Install additional utilities
sudo apt-get install -y gnome-tweaks guvcview ubuntu-restricted-extras ttf-mscorefonts-installer

# Install GNOME shell extensions
sudo apt-get install -y gnome-shell-extensions

# Install OpenJDK
sudo apt-get install -y openjdk-11-jre-headless 

# Install Oh My Posh
sudo curl -s https://ohmyposh.dev/install.sh | sudo bash -s
echo 'eval "$(oh-my-posh init bash --config ~/ohmyposh.omp.json)"' >> ~/.bashrc

# Install NVM and Node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install node # "node" is an alias for the latest version

# Install Docker prerequisites
sudo apt-get install -y containerd.io docker-buildx-plugin docker-compose-plugin

# Remove any old Docker packages
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
  sudo apt-get remove -y $pkg
done

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the Docker repository to APT sources
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli

# Manage Docker as a non-root user
sudo groupadd docker
sudo usermod -aG docker $USER

# Change ownership and permissions of Docker config directory
if [ -d "/home/$USER/.docker" ]; then
    sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
    sudo chmod g+rwx "$HOME/.docker" -R
fi

# Enable Docker to start on boot
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Cleanup temporary directory
rm -rf "$Tmp_Dir"

# Inform the user about manual steps
echo "Docker installation complete."
echo "Please logout and login again before using Docker to apply group changes."
echo "Please download Docker Desktop from https://docs.docker.com/desktop/install/ubuntu/ and then run sudo apt
