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
    ttf-liberation \
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

# set -l java_packages jdk-openjdk \

set -l node_packages \
    nodejs \
    typescript \
    typescript-language-server

set -l python_packages \
    python-lsp-black \
    python-lsp-server

set -l rust_packages \
    rust \
    rustup \
    rust-analyzer

sudo pacman -Syyu --needed --noconfirm \
    $main_packages \
    $c_packages \
    $emacs_packages \
    $node_packages \
    $python_packages \
    $rust_packages

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
    gnome-tour \
    papers

for package in $packages_to_remove
    if pacman -Q $package >/dev/null
        echo "Removing $package..."
        sudo pacman -Rns --noconfirm $package
    else
        echo "$package isn't installed. Skipping."
    end
end
