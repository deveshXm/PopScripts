#!/bin/bash

source $(dirname "$0")/utils/multi_select.sh

function install_snap {
    echo ""
    echo "Installing Snap..."
    sudo apt install snapd
}

function install_edge {
    echo ""
	echo "Installing Edge..."
	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
    sudo rm microsoft.gpg
    sudo apt update && sudo apt install microsoft-edge-stable
}

function install_chrome {
    echo ""
	echo "Installing Chrome..."
    sudo apt install wget
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    sudo apt-get install -f
}

function install_brave {
    echo ""
	echo "Installing Brave..."
    sudo apt install curl
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install brave-browser
}

function install_python {
    echo ""
	echo "Installing Python..."
    sudo apt-get install python3
}

function install_java_11 {
    echo ""
	echo "Installing Java 11..."
    sudo apt install openjdk-11-jre-headless 
}

function install_android_studio {
    echo ""
	echo "Installing Android Studio..."
    sudo add-apt-repository ppa:maarten-fonville/android-studio
    sudo apt update
    sudo apt install android-studio
    echo 'export ANDROID_HOME=$HOME/Android/Sdk' >> ~/.bashrc
    echo 'export PATH=$PATH:$ANDROID_HOME/emulator' >> ~/.bashrc
    echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.bashrc
}

function install_java_17 {
    echo ""
	echo "Installing Java 17..."
    sudo apt install openjdk-17-jdk
}

function install_nvm {
    echo ""
	echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    nvm install node # "node" is an alias for the latest version
}

function install_code {
    echo ""
    echo "Installing Code..."
    sudo apt install code
}

function install_docker_engine {
    echo ""
    echo "Installing Docker Engine..."
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    # Add the repository to Apt sources:
    echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo docker run hello-world

    read -p "Do you want to add your user to the docker group? (y/n)" -n 1 docker

    if [ "$docker" = "y" | "$docker" = "Y" ]; then
        sudo groupadd docker
        sudo usermod -aG docker $USER
        newgrp docker
    fi

    read -p "Do you want to start Docker on boot? (y/n)" -n 1 boot

    if [ "$boot" = "y" | "$boot" = "Y" ]; then
        sudo systemctl enable docker.service
        sudo systemctl enable containerd.service
    fi
}

function install_vlc {
    echo ""
    echo "Installing VLC..."
    sudo apt install vlc
}

function install_vim {
    echo ""
    echo "Installing Vim..."
    sudo apt install vim
}

OPTIONS_VALUES=("Edge" "Chrome" "Brave" "Python" "Java 11" "Java 17" "NVM (Node LTS)" "Android Studio" "Snap" "Code" "Docker Engine" "VLC" "Vim")

for i in "${!OPTIONS_VALUES[@]}"; do
	OPTIONS_STRING+="${OPTIONS_VALUES[$i]};"
done

prompt_for_multiselect SELECTED "$OPTIONS_STRING"

for i in "${!SELECTED[@]}"; do
	if [ "${SELECTED[$i]}" == "true" ]; then
		if(($i == 0)); then
			install_edge
		elif(($i == 1)); then
			install_chrome
		elif(($i == 2)); then
			install_brave
		elif(($i == 3)); then
			install_python
		elif(($i == 4)); then
			install_java_11
		elif(($i == 5)); then
			install_java_17
		elif(($i == 6)); then
			install_nvm
		elif(($i == 7)); then
			install_android_studio
		elif(($i == 8)); then
			install_snap
		elif(($i == 9)); then
			install_code
		elif(($i == 10)); then
			install_docker_engine
		elif(($i == 11)); then
			install_vlc
		elif(($i == 12)); then
			install_vlm
		fi
	fi
done


