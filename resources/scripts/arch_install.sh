#!/bin/bash
if [ $(id -u) = 0 ]; then
   echo "[⚠] - This script should not be run as root or sudo. Run with bash arch_install.sh, going out..."
   exit 1
fi

echo "★ - Intall script HilzuUB - ★"

echo "[★] - Checking required packages:"

sudo pacman -S tree wget p7zip ffmpeg wget git neofetch python-pip --noconfirm

echo "[✔] - All packages are properly installed."


cd $HOME

if [ -d "$HOME/Loader" ] ; then
    echo "[★] - Folder Loader already exists"
    echo "[★] - Removing old installation"
    rm -rf /Loader
fi

echo "[★] - Cloning Loader in \"$HOME\""

git clone https://github.com/fnixdev/Loader.git
cd Loader

if [ -d "$HOME/Loader/hilzu-venv" ] ; then
    echo "[★] - hilzu-venv already exists"
else
    {
        echo "[★] - Creating hilzu-venv and installing reqs."
        python -m venv hilzu-venv
        echo "[✔] - hilzu-venv created"
        source $HOME/Loader/hilzu-venv/bin/activate
    } || {
        echo "[⚠] - Could not create Virtual Env."
        exit 1
    }
fi

echo "[★] - Installing requeriments"
sudo bash install_req
echo "[✔] - Requeriments installed."

echo -n "[ ? ] - It is likely that some modules are not installed even with script, do you want to run fix?"
read answer </dev/tty
if [[ "$answer" != "${answer#[Yy]}" ]]; then
    sudo pip install heroku3
fi

cp config.env.sample config.env

echo -n "[ ? ] - Do you want to generate your string session now? (Yy/Nn)?"
read answer </dev/tty
if [[ "$answer" != "${answer#[Yy]}" ]]; then
    bash genStr
fi


printf "\n[✔] - Installation complete, configure your config.env and start the bot with bash run\n"
