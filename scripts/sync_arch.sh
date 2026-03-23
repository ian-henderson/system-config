#!/usr/bin/env bash

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

sudo pacman -Syu
sudo pacman -S --needed --noconfirm "${packages[@]}"

# Installs audio firmware for Dell Inspiron 7630
product_name=$(cat /sys/devices/virtual/dmi/id/product_name)
if [ "$product_name" == *"Inspiron 16 Plus 7630"* ]; then
	sudo pacman -S --needed --noconfirm sof-firmware
fi

# Rustup
rustup default stable

# Paru
(
	dev_dir="$HOME/Developer"
	mkdir -p "$dev_dir" || {
		echo "Error: Failed to make dir: $dev_dir. Exiting."
		exit 1
	}
	cd "$dev_dir" || {
		echo "Error: Failed to cd to dir: $dev_dir. Exiting."
		exit 1
	}
	paru_dir="$dev_dir/paru"
	sudo pacman -S --needed --noconfirm base-devel
	if [ -d "$paru_dir" ]; then
		cd "$paru_dir"
		before=$(git rev-parse HEAD)
		git pull
		after=$(git rev-parse HEAD)
		if [ "$before" != "$after" ]; then
			echo "New changes were pulled"
			makepkg -si
		else
			echo "No changes"
		fi
	else
		git clone https://aur.archlinux.org/paru.git "$paru_dir"
		cd "$paru_dir"
		makepkg -si
	fi
)

if command -v paru >/dev/null 2>&1; then
	paru -S --needed --noconfirm vscodium-bin
fi

packages_to_remove=(
	elisa
	okular
)
for package in "${packages_to_remove[@]}"; do
    if pacman -Q "$package" >/dev/null 2>&1; then
        echo "Removing $package..."
        sudo dnf remove -y "$package"
    fi
done

sudo systemctl enable --now \
	 bluetooth.service \
	 power-profiles-daemon.service
