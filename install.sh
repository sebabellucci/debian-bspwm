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

sudo nala install nmap pulseaudio pavucontrol alsa-utils mpv xdg-user-dirs suckless-tools xorg feh neofetch htop chromium mplayer mpv libfreetype6-dev libimlib2-dev -y
sudo nala install unzip wget curl build-essential devscripts software-properties-common psmisc mangohud papirus-icon-theme fonts-noto-color-emoji libxft-dev simplescreenrecorder i3lock -y
sudo nala install xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev libuv1-dev -y
sudo nala install bison flex libstartup-notification0-dev check autotools-dev libpango1.0-dev librsvg2-bin librsvg2-dev libcairo2-dev libglib2.0-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev -y
sudo nala install flameshot policykit-1 blueman terminator nm-tray nm-tray-l10n thunar arandr gdebi apcalc bspwm sxhkd rofi dunst picom polybar alacritty check slim libpam0g-dev libxrandr-dev -y

xdg-user-dirs-update
sudo systemctl enable slim.service

cd $builddir
mkdir -p ~/.config
mkdir -p ~/.fonts
mkdir -p ~/Pictures/Backgrounds
mkdir -p ~/Pictures/Screenshots
cp -R dotfiles/* ~/.config/
cp wallpapers/* ~/Pictures/Backgrounds/
sudo cp fonts/* /usr/share/fonts/truetype/
sudo cp dotfiles/slim/slim.conf /etc
sudo cp dotfiles/slim/blue-sky /usr/share/slim/themes
chown -R $username:$username ~/
rm -r -d ~/.config/slim
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/polybar/scripts/launcher
chmod +x ~/.config/polybar/scripts/powermenu
chmod +x ~/.config/polybar/scripts/powermenu_alt

cd /tmp
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
/tmp/nerd-fonts/install.sh 