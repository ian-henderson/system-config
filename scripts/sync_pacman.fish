#!/usr/bin/env fish

sudo pacman -Syyu

set -l main_packages \
	bat \
	btop \
	fastfetch \
	git \
	htop \
	lolcat \
	man-db \
	neovim \
	power-profiles-daemon \
	tree \
	wl-clipboard

set -l emacs_packages \
	emacs-wayland \
	ispell \
	shfmt

set -l rust_packages \
	rust \
	rustup

sudo pacman -S --needed --noconfirm \
	$main_packages $emacs_packages $rust_packages

# install rust stable channel and set as default
rustup default stable

sudo systemctl enable --now \
	bluetooth \
	power-profiles-daemon

sudo pacman -Rns \
	epiphany \
	gnome-maps \
	gnome-music \
	gnome-system-monitor \
	gnome-tour
