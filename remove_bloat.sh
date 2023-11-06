#!/bin/bash

# Setup Script

set -e  # Exit immediately if a command exits with a non-zero status.

# Uninstall Bloatware Apps
sudo apt-get update || { echo "Failed to update package lists, exiting." >&2; exit 1; }
sudo apt-get install --fix-missing || { echo "Failed to fix missing packages, exiting." >&2; exit 1; }

remove_app() {
    sudo apt-get --purge remove -y "$1" || { echo "Failed to remove $1, continuing with next app." >&2; }
}

# List of bloatware apps to remove
apps=(
    "yelp*"
    "gnome-logs"
    "seahorse"
    "gnome-contacts"
    "geary"
    "libreoffice*"
    "gnome-weather"
    "ibus-mozc"
    "mozc-utils-gui"
    "gucharmap"
    "simple-scan"
    "popsicle"
    "popsicle-gtk"
    "totem*"
    "lm-sensors*"
    "xfburn"
    "xsane*"
    "hv3"
    "exfalso"
    "parole"
    "quodlibet"
    "xterm"
    "redshift*"
    "drawing"
    "hexchat*"
    "thunderbird*"
    "transmission*"
    "transmission-gtk*"
    "transmission-common*"
    "webapp-manager"
    "celluloid"
    "hypnotix"
    "rhythmbox*"
    "librhythmbox-core10*"
    "rhythmbox-data"
    "mintbackup"
    "mintreport"
    "aisleriot"
    "gnome-mahjongg"
    "gnome-mines"
    "quadrapassel"
    "gnome-sudoku"
    "cheese*"
    "pitivi"
    "gnome-sound-recorder"
    "remmina*"
    "gimp*"
    "zorin-windows-app-support-installation-shortcut"
    "firefox-esr"
)

# Loop through the list of apps and remove them
for app in "${apps[@]}"; do
    remove_app "$app"
done

# System Update and Upgrade
sudo apt-get upgrade --allow-downgrades -y || { echo "Failed to upgrade packages, exiting." >&2; exit 1; }
sudo apt-get full-upgrade --allow-downgrades -y || { echo "Failed to full-upgrade packages, exiting." >&2; exit 1; }

# System Clean Up
sudo apt-get autoremove -y || { echo "Failed to autoremove packages, exiting." >&2; exit 1; }
sudo apt-get autoclean || { echo "Failed to autoclean packages, exiting." >&2; exit 1; }
sudo apt-get clean || { echo "Failed to clean packages, exiting." >&2; exit 1; }

# End of Script

# Display Installation Complete Message
echo "All good now :)"
echo "Please, restart the computer, backup your system using Timeshift (if you installed it and want to) and then run the 2nd Script to install all your Apps."
