#!/usr/bin/env bash

sudo apt update -y
sudo apt full-upgrade -y

main_packages=(
	batcat
	btop
	fastfetch
	htop
	lolcat
	neovim
	starship
)

sudo apt install -y "${main_packages[@]}"
