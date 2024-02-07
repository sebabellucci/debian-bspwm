#!/bin/bash

if [ "$(whoami)" == "root" ]; then
    exit 1
fi

echo "Instalar y configurar BSPWM"
echo "partiendo de una instalación mínima de"
echo "Debian GNU/Linux 12 - Bookworm - 64 bits"


username=$(id -u -n 1000)
builddir=$(pwd)

sudo apt update
sudo apt upgrade -y
sudo apt install nala -y

sudo nala install nmap pulseaudio pavucontrol alsa-utils mpv xdg-user-dirs suckless-tools xorg feh neofetch htop -y
sudo nala install unzip wget curl build-essential devscripts software-properties-common psmisc mangohud papirus-icon-theme fonts-noto-color-emoji slim -y
sudo nala install flameshot policykit-1 blueman terminator nm-tray nm-tray-l10n thunar arandr gdebi apcalc -y
sudo nala install bspwm sxhkd rofi dunst picom -y

xdg-user-dirs-update
sudo systemctl enable slim.service

cd $builddir
mkdir -p ~/.config/.config
mkdir -p ~/.config/.fonts
mkdir -p ~/Pictures/backgrounds
cp -R dotfiles/* ~/.config/
cp wallpapers/* ~/Pictures/backgrounds/
chown -R $username:$username ~/
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/reasignar-ws.sh
chmod +x ~/.config/bspwm/low_bat_notifier.sh
chmod +x ~/.config/bspwm/systemtray.sh
chmod +x ~/.config/polibar/launch.sh

cd /tmp
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
/tmp/nerd-fonts/install.sh 