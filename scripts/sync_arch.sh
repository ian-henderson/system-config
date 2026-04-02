#!/usr/bin/env bash

echo "SYNCHRONIZING ARCH"

scripts_dir="$HOME/Developer/system-config/scripts"

sudo pacman -Syu

packages=(
	archlinux-wallpaper
	bat
	btop
	cmake
	emacs-wayland
	fastfetch
	htop
	less                   # git diff
	lolcat
	make
	man-db
	neovim
	nvm
	pngquant
	power-profiles-daemon
	python-mutagen         # required by yt-dlp
	python-pip             # global pip
	rustup                 # paru
	sddm-kcm
	starship
	unzip
	wl-clipboard
	yt-dlp
)

# TODO: find conda package (python)

sudo pacman -S --needed --noconfirm "${packages[@]}"

# Installs audio firmware for Dell Inspiron 7630
product_name=$(cat /sys/devices/virtual/dmi/id/product_name)
if [ "$product_name" == *"Inspiron 16 Plus 7630"* ]; then
	sudo pacman -S --needed --noconfirm sof-firmware
fi

# NVM
init_nvm="/usr/share/nvm/init-nvm.sh "
if [ -f "$init_nvm" ]; then
	echo "INITIALIZING NVM"
	. "$init_nvm"
else
	echo "NVM INIT SCRIPT MISSING"
fi

# Rustup
if pacman -Q rustup >/dev/null 2>&1; then
	rustup default stable
else
	echo "MISSING RUSTUP"
fi

# Paru
sync_paru="$scripts_dir/sync_paru.sh"
[ -x "$sync_paru" ] && "$sync_paru"

# Flatpak
sync_flatpak="$scripts_dir/sync_flatpak.sh"
[ -x "$sync_flatpak" ] && "$sync_flatpak"

packages_to_remove=(
	elisa
	okular
)
for package in "${packages_to_remove[@]}"; do
    if pacman -Q "$package" >/dev/null 2>&1; then
        echo "Removing $package..."
        sudo pacman -Rns --noconfirm "$package"
    fi
done

sudo systemctl enable --now \
	 bluetooth.service \
	 power-profiles-daemon.service
