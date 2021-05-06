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
echo "Welcome, this is a simple desktop environment or window manager installer for ArchLinux! See my github profile: https://github.com/FrancescoXD"
echo ""
# Starting
echo "What desktop environment (DE) do you need?"
echo "g - GNOME"
echo "d - Deepin"
echo "k - KDE Plasma"
echo "x - XFCE"
echo "What tiling window manager (TWM) do you need?"
echo "i - i3wm"
echo "s - Sway (Wayland)"
echo "=> "
read desktopEnvironment

# Install git
sudo pacman -Sy git

# Check desktop environment
if [ $desktopEnvironment == g ]; then
	echo "Installing GNOME with display manager GDM..."
	sudo pacman -Syu --noconfirm xorg gnome gnome-extra
	# Enable display manager
	sudo systemctl enable gdm
	selectedDE=true
elif [ $desktopEnvironment == k ]; then
	echo "Installing Plasma with display manager SDDM..."
	sudo pacman -Syu --noconfirm plasma-meta sddm kde-applications
	# Enable display manager
	sudo systemctl enable sddm
	selectedDE=true
elif [ $desktopEnvironment == x ]; then
	echo "Installing XFCE with display manager LXDM..."
	sudo pacman -Syu --noconfirm xorg xfce4 xfce4-goodies lightdm lightdm-gtk-greeter
	# Enable display manager
	sudo systemctl enable lightdm
	selectedDE=true
elif [ $desktopEnvironment == d ]; then
	echo "Installing Deepin with display manager LightDM..."
	sudo pacman -Syu --noconfirm xorg deepin deepin-extra lightdm lightdm-gtk-greeter
	# Enable display manager
	sudo systemctl enable lightdm
	selectedDE=true
elif [ $desktopEnvironment == i ]; then
	echo "Installing i3wm with display manager LightDM..."
	echo "Check https://github.com/nullgemm/ly for more info."
	sudo pacman -Syu --noconfirm xorg i3 lightdm lightdm-gtk-greeter
	# Download and install Ly
	sudo systemctl enable lightdm
	selectedDE=true
elif [ $desktopEnvironment == s ]; then
	echo "Installing Sway with display manager Ly..."
	echo "Check https://github.com/nullgemm/ly for more info."
	sudo pacman -Syu --noconfirm xorg sway swaylock swayidle dmenu alacritty
	# Download and install Ly
	git clone https://github.com/nullgemm/ly.git
	cd ly
	make github
	make
	sudo make install
	# Enable display manager
	sudo systemctl enable ly.service
	selectedDE=true
else
	echo "Error: you did not choose a valid desktop environment!"
fi

# Downloading pulseaudio
if [ $selectedDE == "true" ]; then
	echo "Installing extra stuff..."
	pacman -S --noconfirm pulseaudio pulseaudio-alsa
	echo ""
	echo "Thanks for using this script! Now you have to reboot."
fi

# Finally
echo ""
echo "Thanks for using this script!"
