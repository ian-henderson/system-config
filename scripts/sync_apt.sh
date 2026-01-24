#!/usr/bin/env bash

sudo apt update -y
sudo apt full-upgrade -y

main_packages=(
	bat
	btop
	fastfetch
	htop
	lolcat
	neovim
	starship
)

transcoding_packages=(
	intel-media-va-driver-non-free
	vainfo
)

sudo apt install -y \
	 "${main_packages[@]}" \
	 "${transcoding_packages[@]}"
