#!/bin/bash

function add_brave_repo() {
	sudo apt install curl -y

	sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
		https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

	echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" |
		sudo tee /etc/apt/sources.list.d/brave-browser-release.list
}

add_brave_repo

sudo apt update -y

sudo apt dist-upgrade -y

sudo apt upgrade -y

sudo apt install -y \
	bat \
	brave-browser \
	btop \
	cbonsai \
	cmake \
	curl \
	distrobox \
	emacs-gtk \
	emacs-common-non-dfsg \
	fastfetch \
	flatpak \
	gcc \
	git \
	libvterm-dev \
	lolcat \
	make \
	neovim \
	shfmt \
	thunderbird \
	tree \
	wget \
	wl-clipboard

# Rust-specific packages
sudo apt install -y \
	libssl-dev \
	pkg-config

# SICP packages
sudo apt install -y guile-3.0

sudo apt remove -y \
	evolution \
	firefox-esr \
	gnome-games \
	gnome-maps \
	gnome-music \
	gnome-system-monitor \
	gnome-tour \
	libreoffice* \
	malcontent \
	shotwell \
	yelp

# TODO: add vscode and 1password

sudo apt autoremove -y
