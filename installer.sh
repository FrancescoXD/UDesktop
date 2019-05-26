#!/bin/bash
# Selected boolean
selectedDE=false

printf "
  _    _ _____            _    _              
 | |  | |  __ \          | |  | |             
 | |  | | |  | | ___  ___| | _| |_ ___  _ __  
 | |  | | |  | |/ _ \/ __| |/ / __/ _ \| '_ \ 
 | |__| | |__| |  __/\__ \   <| || (_) | |_) |
  \____/|_____/ \___||___/_|\_\\__\___/| .__/ 
                                       | |    
                                       |_|    
"
echo ""
echo "Welcome, this is a complete desktop environment installer for ArchLinux! See my github profile: https://github.com/FrancescoXD"
echo ""
# Starting
echo "What desktop environment (DE) do you need?"
echo "g - GNOME"
echo "l - LXDE"
echo "k - KDE Plasma"
echo "x - XFCE"
read desktopEnvironment

# Check desktop environment
if [ $desktopEnvironment == g ]; then
	echo "Installing GNOME with display manager LXDM..."
	pacman -Syu
	pacman -S xorg xorg-server gnome gnome-extra lxdm
	# Enable display manager
	systemctl enable lxdm
	selectedDE=true
elif [ $desktopEnvironment == l ]; then
	echo "Installing LXDE with display manager LXDM..."
	pacman -Syu
	pacman -S xorg xorg-server lxde lxde-common lxsession desktop-file-utils gamin lxdm
	# Enable display manager
	systemctl enable lxdm
	selectedDE=true
elif [ $desktopEnvironment == k ]; then
	echo "Installing KDE Plasma with display manager SDDM..."
	pacman -Syu
	pacman -S xorg xorg-server plasma sddm kde-applications lxdm
	# Enable display manager
	systemctl enable sddm
	selectedDE=true
elif [ $desktopEnvironment == x ]; then
	echo "Installing XFCE with display manager LXDM..."
	pacman -Syu
	pacman -S xorg xorg-server xfce4 xfce4-goodies lxdm
	# Enable display manager
	systemctl enable lxdm
	selectedDE=true
else
	echo "Error: you did not choose a valid desktop environment!"
fi

# Downloading pulseaudio
if [ $selectedDE == "true" ]; then
	echo "Installing extra stuff..."
	pacman -S pulseaudio pulseaudio-alsa
	echo ""
	echo "Thanks for using this script!"
fi

echo ""
echo "Thanks for using this script!"
