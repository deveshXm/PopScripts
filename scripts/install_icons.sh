#!/bin/bash

# Install GNOME shell extensions
sudo apt install gnome-shell-extensions
sudo apt install gnome-tweaks

cd ~/ && git clone https://github.com/bikass/kora.git
cd kora
mv kora /usr/share/icons/ 
mv kora-light /usr/share/icons/ 
mv kora-light-panel /usr/share/icons/ 
mv kora-pgrey /usr/share/icons/
cd ~/ && rm -rf kora 