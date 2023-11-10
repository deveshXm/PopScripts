#!/bin/bash -e

source "$(dirname "$0")/utils/multi_select.sh"

function install_snap {
    sudo apt install -y snapd
}

function install_edge {
    echo "Installing Edge..."
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
    sudo rm microsoft.gpg
    sudo apt update && sudo apt install -y microsoft-edge-stable
}

function install_chrome {
    echo "Installing Chrome..."
    sudo apt install -y wget
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    sudo apt-get install -f
}

function install_brave {
    echo "Installing Brave..."
    sudo apt install -y curl
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install -y brave-browser
}

function install_python {
    echo "Installing Python..."
    sudo apt-get install -y python3
}

function install_java_11 {
    echo "Installing Java 11..."
    sudo apt install -y openjdk-11-jre-headless
}

function install_android_studio {
    echo "Installing Android Studio..."
    sudo add-apt-repository ppa:maarten-fonville/android-studio
    sudo apt update
    sudo apt install -y android-studio
    echo 'export ANDROID_HOME=$HOME/Android/Sdk' >> ~/.bashrc
    echo 'export PATH=$PATH:$ANDROID_HOME/emulator' >> ~/.bashrc
    echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.bashrc
}

function install_java_17 {
    echo "Installing Java 17..."
    sudo apt install -y openjdk-17-jdk
}

function install_nvm {
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    nvm install node # "node" is an alias for the latest version
}

function install_code {
    echo "Installing VS Code..."
    sudo apt install -y code
}

function install_docker_engine {
    echo "Installing Docker Engine..."
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    echo \
    "deb [arch=\"$(dpkg --print-architecture)\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo docker run hello-world

    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker

    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service
}

function install_vlc {
    echo "Installing VLC..."
    sudo apt install -y vlc
}

function install_vim {
    echo "Installing Vim..."
    sudo apt install -y vim
}

OPTIONS_VALUES=("Edge" "Chrome" "Brave" "Python" "Java 11" "Java 17" "NVM (Node LTS)" "Android Studio" "Snap" "Code" "Docker Engine" "VLC" "Vim")

for i in "${!OPTIONS_VALUES[@]}"; do
    OPTIONS_STRING+="${OPTIONS_VALUES[$i]};"
done

prompt_for_multiselect SELECTED "$OPTIONS_STRING"

for i in "${!SELECTED[@]}"; do
    if [ "${SELECTED[$i]}" == "true" ]; then
        case $i in
            0) install_edge ;;
            1) install_chrome ;;
            2) install_brave ;;
            3) install_python ;;
            4) install_java_11 ;;
            5) install_java_17 ;;
            6) install_nvm ;;
            7) install_android_studio ;;
            8) install_snap ;;
            9) install_code ;;
            10) install_docker_engine ;;
            11) install_vlc ;;
            12) install_vim ;;
        esac
    fi
done
