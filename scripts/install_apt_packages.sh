#!/bin/bash

sudo apt update -y

sudo apt dist-upgrade -y

sudo apt upgrade -y

sudo apt install -y \
	bat \
	btop \
	cbonsai \
	cmake \
	curl \
	distrobox \
	emacs-gtk \
	emacs-common-non-dfsg \
	fastfetch \
	firefox \
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
