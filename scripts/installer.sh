#!/bin/sh


# 1. Initialization and Safety
echo "WARNING: work in progress"
printf "Do you want to continue? (Y/N) "
read -r response

if [ "$response" != "Y" ] && [ "$response" != "y" ]; then
  echo "Exiting..."
  exit 1
fi

echo "Xgui4 OS Dotfiles Installer - Prototype 2 Version"

echo "Preparing the gtk and icons theme" 

touch gtk/.gtkrc-2.0

cat gtk/.gtkrc-2.0-pre-defned > gtk/.gtkrc-2.0

touch gtk/.icons/default/icon.theme

cat gtk/icons/default/index.default.theme > gtk/.icon/default/icon.theme

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

echo "List of Operating System available?"

echo "1. Arch based OS"
echo "2. FreeBSD"

printf "What is your Operating System?"
read -r operating_system

if [ $operating_system = "1" ]; then

  echo "First, do you want a XLibre or Xorg for an X server?"
  printf "So Do you want to Install XLibre ? (Y/N) ?"
  read -r confirm_xlibre

  if [ $confirm_xlibre = "Y"] || [$confirm_xlibre = "y" ]; then
    curl -O https://x11libre.net/repo/arch_based/x86_64/install-xlibre.sh 
    sudo chmod +x install-xlibre.sh
    sudo ./install-xlibre.sh || echo "[Error] XLibre installation script has failed."
  fi

  else sudo pacman -S xorg-server;

  qtile_choosen=0
  hyprland_choosen=0
  i3_choosen=0
  spectrwm_choosen=0

  printf "Do you want to install i3 ?"
  read -r user_input

  if [ user_input = "yes" ] || [ user_input = "Yes" ]; then
    i3_choosen=1
  fi 

  if [ $operating_system = "1"]; then 
    printf "Do you want to install Qtile ?"
    read -r user_input

    if [ user_input = "yes" ] || [ user_input = "Yes" ]; then
    qtile_choosen=1
    fi 

    printf "Do you want to install Hyprland ?"
    read -r user_input

    if [ user_input = "yes" ] || [ user_input = "Yes" ]; then
      hyprland_choosen=1
    fi 

    printf "Do you want to install spectrwm ?"
    read -r user_input

    if [ user_input = "yes" ] || [ user_input = "Yes" ]; then
      spectrwm_choosen=1
    fi 
  fi

  # Define the JSON file
  ARCH="arch/arch-essential-pkg.json"
  I3="arch/i3-setup.json"
  HYPRARCH="arch/hyprarch-setup.json"
  QTILE="arch/qtile-setup.json"

  packages=$(jq -r '.pacman[]' "$ARCH")
  sudo pacman -S --noconfirm $packages

  aur=$(jq -r '.aur[]' "$ARCH")
  yay -S --needed --noconfirm $aur

  if [ $i3_choosen = 1 ]; then
    packages=$(jq -r '.pacman[]' "$I3")
    sudo pacman -S --needed --noconfirm $packages
  fi

  if [ $hyprland = 1 ]; then
    packages=$(jq -r '.pacman[]' "$HYPRARCH")
    sudo pacman -S --needed --noconfirm $packages
    aur=$(jq -r '.aur[]' "$HYPRARCH")
    yay -S --needed --noconfirm $aur
  fi

  if [ $qtile_choosen = 1 ]; then
    packages=$(jq -r '.pacman[]' "$QTILE")
    sudo pacman -S --needed --noconfirm $packages
    aur=$(jq -r '.aur[]' "$QTILE")
    yay -S --needed --noconfirm $aur
  fi

  cd ~/.dotfiles

  if [ $qtile_choosen = 1 ]; then 
    stow --adopt qtile
  fi

  if [ $hyprland_choosen = 1 ]; then 
    stow --adopt hyprland waybar hyprshell 
  fi

  if [ $i3_choosen = 1 ]; then 
    stow --adopt i3 polybar 
  fi

  if [ $spectrwm_choosen = 1 ]; then 
    stow spectrwm
  fi
  stow --adopt bash fastfetch fish gtk kitty libinput-gestures kitty picom qt rofi starship wallpapers xsettings
fi

else 
  printf "Do you want to install an X11 Server for an X11 Window Manager? (Y/N)")
  read -r confirm_x11
  if [ $confirm_x11 = "Y"] || [ $confirm_x11 = "y" ]; then
    sudo pkg install -y xorg-server
  fi

  # Define the JSON file
  ESSENTIAL="freebsd/freebsd-essential-pkg.json"
  I3="freebsd/i3-setup.json"

  packages=$(jq -r '.pkg[]' "$ESSENTIAL")
  sudo pkg install -y $packages

  packages=$(jq -r '.pkg[]' "$I3")
  sudo pkg install -y $packages

  cd ~/.dotfiles

  stow --adopt fastfetch fish gtk i3 kitty libinput-gestures kitty picom polybar qt rofi starship wallpapers xsettings
fi
