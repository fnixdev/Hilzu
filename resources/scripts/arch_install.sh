#!/bin/bash
if [ $(id -u) = 0 ]; then
   echo "[⚠] - This script should not be run as root or sudo. Run with bash arch_install.sh, going out..."
   exit 1
fi

echo "★ - Intall script HilzuUB - ★"

cmd="sudo pacman -Sy"
packages="tree wget2 p7zip-full ffmpeg wget git neofetch python-pip"

echo "[★] - Checking required packages:"

for package in $packages ; do
    cmd="$cmd $package"
done


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
        echo "[★] - Installing requeriments"
        bash install_req
        echo "[✔] - Requeriments installed."
    } || {
        echo "[⚠] - Could not create Virtual Env."
        exit 1
    }
fi

cp config.env.sample config.env

echo -n "[ ? ] - Do you want to generate your string session now? (Yy/Nn)?"
read answer </dev/tty
if [[ "$answer" != "${answer#[Yy]}" ]]; then
    bash genStr
fi

printf "\n[✔] - Installation complete, configure your config.env and start the bot with bash run\n"
