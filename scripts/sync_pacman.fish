#!/usr/bin/env fish

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

set -l c_packages \
    bear \
    ccls \
    cmake \
    gcc

set -l emacs_packages \
    emacs-wayland \
    ispell \
    shfmt

set -l rust_packages \
    rust \
    rustup

sudo pacman -Syyu --needed --noconfirm \
    $main_packages $c_packages $emacs_packages $rust_packages

# install rust stable channel and set as default
rustup default stable

sudo systemctl enable --now \
    bluetooth \
    power-profiles-daemon

set -l packages_to_remove \
    epiphany \
    gnome-maps \
    gnome-music \
    gnome-system-monitor \
    gnome-tour

for package in $packages_to_remove
    if pacman -Q $package >/dev/null
        echo "Removing $package..."
        sudo pacman -Rns --noconfirm $package
    else
        echo "$package isn't installed. Skipping."
    end
end
