#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run ./install.sh" 2>&1
  exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)

apt update && apt upgrade -y
apt install nala -y

nala -y install nmap pulseaudio pavucontrol pcmanfm alsa-utils mpv xdg-user-dirs alacritty suckless-tools xorg feh nitrogen neofetch 
nala -y install unzip wget pavucontrol build-essential psmisc mangohud papirus-icon-theme fonts-noto-color-emoji slim
nala -y install flameshot policykit-1 blueman terminator nm-tray nm-tray-l10n thunar arandr gdebi curl htop wget build-essential devscripts software-properties-common
nala -y install bspwm sxhkd rofi apcalc dunst dunstify picom xdg-user-dirs

xdg-user-dirs-update
systemctl enable slim.service

cd $builddir
mkdir -p /home/$username/.config
mkdir -p /home/$username/.fonts
mkdir -p /home/$username/Pictures/backgrounds
cp -R dotfiles/* /home/$username/.config/
cp walpapers/* /home/$username/Pictures/backgrounds/
chown -R $username:$username /home/$username
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/polibar/lauch.sh

cd /tmp
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
/tmp/nerd-fonts/install.sh 