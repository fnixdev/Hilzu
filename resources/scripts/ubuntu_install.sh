#!/bin/bash


echo "Installing packages"
sudo apt-get update -y
sudo apt-get install tree wget2 p7zip-full jq ffmpeg wget git neofetch mediainfo screen -y
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb -y
sudo rm google-chrome-stable_current_amd64.deb

echo "Installing Python3.9..."
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt install python3.9 -y
sudo apt install python3-pip

echo "Cloning repo"
cd ~
git clone https://github.com/fnixdev/Loader.git && cd Loader

echo "Installing requirements"
bash install_req

echo -n "Do you want to generate your string session now? (y/n)?"
read answer </dev/tty
if [[ "$answer" != "${answer#[Yy]}" ]]; then
    bash genStr
fi
