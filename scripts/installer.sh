#!/bin/sh

# to fix dolphin : sudo ln -sf /etc/xdg/menus/arch-applications.menu /etc/xdg/menus/applications.menu 

# Exit on any error
set -e

echo "Preparing installer"

echo "Installing Yay AUR Helper"

sudo pacman -S --needed --noconfirm base-devel git

git clone https://aur.archlinux.org/yay.git /tmp/yay

cd /tmp/yay
makepkg -si --noconfirm

cd "$HOME"
rm -rf /tmp/yay

echo "yay installation complete!"

echo "Installing jq"

sudo pacman -S --needed --noconfirm jq

sudo pacman -S xorg-server

qtile_choosen=0
hyprland_choosen=0
i3_choosen=0
niri_choosen=0

printf "Do you want to install and configure i3 ?"
read -r user_input

if [ "$user_input" = "yes" ] || [ "$user_input" = "Yes" ]; then
    i3_choosen=1
fi 

printf "Do you want to install and configure Qtile ?"
read -r user_input

if [ "$user_input" = "yes" ] || [ "$user_input" = "Yes" ]; then
    qtile_choosen=1
fi 

printf "Do you want to install and configure Hyprland ?"
read -r user_input

if [ "$user_input" = "yes" ] || [ "$user_input" = "Yes" ]; then
    hyprland_choosen=1
fi 

printf "Do you want to install and configure Niri ?"
read -r user_input

if [ "$user_input" = "yes" ] || [ "$user_input" = "Yes" ]; then
    niri_choosen=1
fi

# Define the JSON file
ARCH="$HOME/.dotfiles/scripts/data/arch/arch-essential-pkg.json"
I3="$HOME/.dotfiles/scripts/data/arch/i3-setup.json"
HYPRARCH="$HOME/.dotfiles/scripts/data/arch/hyprarch-setup.json"
QTILE="$HOME/.dotfiles/scripts/data/arch/qtile-setup.json"
NIRI="$HOME/.dotfiles/scripts/data/arch/niri-setup.json"

packages=$(jq -r '.pacman[]' "$ARCH")
sudo pacman -S --noconfirm "$packages"

aur=$(jq -r '.aur[]' "$ARCH")
yay -S --needed --noconfirm "$aur"

if [ "$i3_choosen" = 1 ]; then
    packages=$(jq -r '.pacman[]' "$I3")
    sudo pacman -S --needed --noconfirm "$packages"
fi

if [ "$hyprland_choosen" = 1 ]; then
    packages=$(jq -r '.pacman[]' "$HYPRARCH")
    sudo pacman -S --needed --noconfirm "$packages"
    aur=$(jq -r '.aur[]' "$HYPRARCH")
    yay -S --needed --noconfirm "$aur"
fi

if [ "$qtile_choosen" = 1 ]; then
    packages=$(jq -r '.pacman[]' "$QTILE")
    sudo pacman -S --needed --noconfirm "$packages"
    aur=$(jq -r '.aur[]' "$QTILE")
    yay -S --needed --noconfirm "$aur"
fi

if [ "$niri_choosen" = 1 ]; then
    packages=$(jq -r '.pacman[]' "$NIRI")
    sudo pacman -S --needed --noconfirm "$packages"
    aur=$(jq -r '.aur[]' "$NIRI")
    yay -S --needed --noconfirm "$aur"
fi

cd "$HOME/.dotfiles"

if [ "$qtile_choosen" = 1 ]; then 
    stow --adopt qtile
fi

if [ "$hyprland_choosen" = 1 ]; then 
    stow --adopt hyprland 
    stow --adopt waybar 
    stow --adopt caelestia 
fi

if [ "$i3_choosen" = 1 ]; then 
    stow --adopt i3 
    stow --adopt polybar 
    stow --adopt picom 
fi

if [ "$niri_choosen" = 1 ]; then 
    stow --adopt niri 
    stow --adopt DankMaterialShell
fi

stow --adopt bash 
stow --adopt fastfetch 
stow --adopt fish 
stow --adopt kitty 
stow --adopt libinput-gestures 
stow --adopt kitty 
stow --adopt rofi 
stow --adopt starship 
stow --adopt wallpapers 
stow --adopt flameshot
stow --adopt account-profile
stow --adopt gh 
stow --adopt neovim
stow --adopt doom
stow --adopt nano 
stow --adopt btop
stow --adopt zsh
stow --adopt quickshell
