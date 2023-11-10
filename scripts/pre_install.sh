#!/bin/bash -e

# Install essential packages
sudo apt-get install -y curl wget git software-properties-common vim ca-certificates gnupg || true
# System Update and Upgrade
sudo apt update || true
sudo apt install --fix-missing -y || true
sudo apt upgrade --allow-downgrades -y || true
sudo apt full-upgrade --allow-downgrades -y || true
sudo npm install -g npm@latest || true

# Flatpak Update
flatpak update -y || true

# Flatpak Clean Up
flatpak uninstall --delete-data -y || true
flatpak uninstall --unused -y || true

# System Clean Up
sudo apt install -f || true
sudo apt autoremove -y || true
sudo apt autoclean || true
sudo apt clean || true
