#!/bin/bash

sudo apt update -y

sudo apt dist-upgrade -y

sudo apt upgrade -y

sudo apt install -y \
	bat \
	btop \
	curl \
	distrobox \
	fastfetch \
	firefox \
	flatpak \
	git \
	lolcat \
	neovim \
	tree \
	wget

# Rust-specific packages
sudo apt install -y \
	gcc \
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

