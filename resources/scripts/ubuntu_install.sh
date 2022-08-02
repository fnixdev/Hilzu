#!/bin/bash

echo "[★] - Intall script HilzuUB - ★"

echo

echo "[★] - Installing packages"
sudo apt-get update -y
sudo apt-get install tree wget2 p7zip-full jq ffmpeg wget git neofetch mediainfo screen -y
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb -y
sudo rm google-chrome-stable_current_amd64.deb

## == 

py3="python3"
package=$(dpkg --get-selections | grep $py3 ) 
echo 
echo -n "[★] - Checking if package $py3 is installed."
sleep 2

if [ -n "$package" ] ;
then echo
    echo "[✔] - $py3 it's already installed, skipping"
else echo
    echo "[★] - Package $py3 not found, installing..."
    sudo apt install software-properties-common -y
    sudo add-apt-repository ppa:deadsnakes/ppa -y
    sudo apt install python3.9 python-pip -y
fi
echo "[✔] - All packages are properly installed."

cd ~
echo "[★] - Cloning Loader"

git clone https://github.com/fnixdev/Loader.git
cd Loader

echo "[★] - Installing requirements"
bash install_req

echo -n "[ ? ] - Do you want to generate your string session now? (Yy/Nn)?"
read answer </dev/tty
if [[ "$answer" != "${answer#[Yy]}" ]]; then
    bash genStr
fi
