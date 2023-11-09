#!/bin/bash

# Install GNOME shell extensions
sudo apt install gnome-shell-extensions
sudo apt install gnome-tweaks

# Install Graphite GTK theme
cd ~/ && git clone https://github.com/vinceliuice/Graphite-gtk-theme.git
cd Graphite-gtk-theme && ./install.sh --tweaks rimless darker
cd ~/ && rm -rf Graphite-gtk-theme
