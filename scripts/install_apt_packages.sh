#!/bin/bash

sudo apt update -y

sudo apt dist-upgrade -y

sudo apt upgrade -y

sudo apt install -y \
	bat \
	btop \
	curl \
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

sudo apt remove -y \
	evolution \
	gnome-games \
	gnome-maps \
	gnome-music \
	gnome-tour \
	libreoffice* \
	malcontent \
	yelp

# TODO: add vscode and 1password

sudo apt autoremove -y

