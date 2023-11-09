#!/bin/bash

clear

# Ask for root permission
if (($EUID != 0)); then
  if [[ -t 1 ]]; then
    echo "-------------------------------------------------------"
    echo "|                Welcome to PopScripts!               |"
    echo "-------------------------------------------------------"
    echo "|     Please provide root permission to continue.     |"
    echo "-------------------------------------------------------"
    sudo "$0" "$@"
  else
    exec 1>output_file
    gksu "$0 $@"
  fi
  exit
fi

clear

# Remove Bloatware
echo "-------------------------------------------------------"
echo "|                Welcome to PopScripts!               |"
echo "-------------------------------------------------------"
echo ""
echo -n "Do you want to remove bloatware? (y/n)" 
read -n 1 bloat

if [ "$bloat" = "y" | "$bloat" = "Y" ]; then
    echo -e "Removing Bloatware..."
    source ./scripts/remove_bloat.sh
fi

clear

# Update
echo "-------------------------------------------------------"
echo "|Checking for Updates                                 |"
echo "-------------------------------------------------------"

source ./scripts/pre_install.sh

clear

echo -n "Do you want to install media codecs to play media files like MP#, MPEG4, AVI etc. (y/n)"
read -n 1 media

if [ "$media" = "y" | "$media" = "Y" ]; then
    echo -e "Installing Media Codecs..."
    sudo apt install ubuntu-restricted-extras
fi


clear

# Install Apps
echo "-------------------------------------------------------"
echo "|Let's install your favourite Apps now!               |"
echo "-------------------------------------------------------"
echo "|                     INSTRUCTIONS                    |"
echo "|1. Press UP and DOWN arrow keys to navigate.         |"
echo "|2. Press SPACEBAR to select or de-select.            |"
echo "|3. Press Enter to install selected Apps              |" 
echo "-------------------------------------------------------"

source ./scripts/install_apps.sh

clear 

# Install Themes

echo "-------------------------------------------------------"
echo "|                     GRAPHITE THEME                  |"
echo "-------------------------------------------------------"

echo -n "Do you want to install Graphite Theme? (y/n)"
read -n 1 theme

if [ "$theme" = "y" | "$theme" = "Y" ]; then
  source ./scripts/install_theme.sh
fi

clear

# Install Icons

echo "-------------------------------------------------------"
echo "|                     KORA ICONS                      |"
echo "-------------------------------------------------------"

echo -n "Do you want to install Kora Icons? (y/n)"
read -n 1 icon

if [ "$icon" = "y" | "$icon" = "Y" ]; then
  source ./scripts/install_icons.sh
fi

clear

# Install Oh-my-posh

echo "-------------------------------------------------------"
echo "|                     OH MY POSH                      |"
echo "-------------------------------------------------------"

echo -n "Do you want to install Oh-My-Posh? (y/n)"
read -n 1 omposh

if [ "$omposh" = "y" | "$omposh" = "Y" ]; then
  source ./scripts/install_oh_my_posh.sh
fi

# EXIT
clear

echo "-------------------------------------------------------"
echo "|               POST INSTALLATION GUIDE               |"
echo "-------------------------------------------------------"
echo "|1. Enable Graphite Theme :                           |"
echo "|   - Open Tweaks -> Appearance                       |"
echo "|   - Change Applications -> Graphite Dark            |"
echo "|   - Change Shell -> Graphite Dark                   |"
echo "-------------------------------------------------------"
echo "|1. Enable Icon Theme :                               |"
echo "|   - Open Tweaks -> Appearance                       |"
echo "|   - Change Icons -> Kora                            |"
echo "------------------------------------------------------"
echo "|1. Oh My Posh :                                      |"
echo "|   - It will be enabled but you need to change font  |"
echo "|   - Open Terminal -> Preferences -> Profiles        |"
echo "|   - Change custom font to JetBrainsMono Nerd Font   |"
echo "|   - You can checkout more fonts at nerdfonts.com    |"
echo "|   - You can checkout more themea at ohmyposh.com    |"
echo "-------------------------------------------------------"
echo "|                 YOU'RE GOOD TO GO!                  |"
echo "-------------------------------------------------------"
echo "|                RESTART YOUR SYSTEM                  |"
echo "-------------------------------------------------------"

read -n 1 -s -r -p "Press any key to EXIT"
