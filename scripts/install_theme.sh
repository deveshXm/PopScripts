#!/bin/bash

# Install GNOME shell extensions
sudo apt install -y gnome-shell-extensions

# Install GNOME Tweaks
sudo apt install -y gnome-tweaks

# Install Graphite GTK theme
cd ~/ && git clone https://github.com/vinceliuice/Graphite-gtk-theme.git
cd Graphite-gtk-theme && yes | ./install.sh -y --tweaks rimless darker
cd ~/ && rm -rf Graphite-gtk-theme

gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
gsettings set org.gnome.desktop.interface gtk-theme 'Graphite-Dark'
gsettings set org.gnome.shell.extensions.user-theme name 'Graphite-Dark'

