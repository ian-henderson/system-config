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
	curl \
	distrobox \
	fastfetch \
	fish \
	flatpak \
	git \
	lolcat \
	neovim \
	thunderbird \
	tree \
	wget \
	wl-clipboard

# Rust-specific packages
sudo apt install -y \
	gcc \
	libssl-dev \
	pkg-config

# SICP packages
sudo apt install -y guile-3.0

# Emacs packages
sudo apt install -y \
	autoconf \
	automake \
	cmake \
	emacs-common-non-dfsg \
	emacs-gtk \
	gcc \
	libpng-dev \
	libpoppler-dev \
	libpoppler-glib-dev \
	libvterm-dev \
	libz-dev \
	make \
	pkg-config \
	shfmt

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

# Changes default shell to fish
chsh -s $(which fish) $USER
