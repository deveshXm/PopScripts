#!/bin/bash

# Install essential packages
sudo apt-get install -y curl wget git software-properties-common vim ca-certificates gnupg
# System Update and Upgrade
sudo apt update
sudo apt install --fix-missing -y
sudo apt upgrade --allow-downgrades -y
sudo apt full-upgrade --allow-downgrades -y
sudo npm install -g npm@latest

# Flatpak Update
flatpak update -y

# Flatpak Clean Up
flatpak uninstall --delete-data -y
flatpak uninstall --unused -y

# System Clean Up
sudo apt install -f
sudo apt autoremove -y
sudo apt autoclean
sudo apt clean

echo "Updated"