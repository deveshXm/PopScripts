#!/bin/bash

# Install Oh My Posh
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/bin
echo 'eval "$(oh-my-posh init bash --config ~/ohmyposh.omp.json)"' >> ~/.bashrc

# Setting theme
cd ~/ &&  wget https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/stelbent.minimal.omp.json -O ohmyposh.omp.json

# Install JetBrains Mono font
cd ~/ && wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono
sudo cp JetBrainsMono/*.ttf /usr/local/share/fonts/
sudo fc-cache -fv
rm -rf JetBrainsMono.zip 
rm -rf JetBrainsMono

gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$(gsettings get org.gnome.Terminal.ProfilesList default | awk -F\' '{print $2}')/ font 'JetBrainsMono Nerd Font Regular 12'