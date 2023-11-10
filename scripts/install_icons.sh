#!/bin/bash

# Install GNOME shell extensions
sudo apt install -y gnome-shell-extensions
sudo apt install -y gnome-tweaks

cd ~/ && git clone https://github.com/bikass/kora.git
cd kora
sudo mv kora /usr/share/icons/
sudo mv kora-light /usr/share/icons/
sudo mv kora-light-panel /usr/share/icons/
sudo mv kora-pgrey /usr/share/icons/
cd ~/ && rm -rf kora
gsettings set org.gnome.desktop.interface icon-theme 'kora'
