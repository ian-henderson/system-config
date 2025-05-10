#!/usr/bin/env fish

sudo pacman -Syyu

set -l main_packages \
    bat \
    btop \
    fastfetch \
    ghc \
    git \
    htop \
    lolcat \
    man-db \
    microsoft-edge-stable-bin \
    neovim \
    power-profiles-daemon \
    proton-pass-bin \
    thunderbird \
    timeshift \
    tree \
    ttf-dejavu \
    ttf-hack-nerd \
    ttf-liberation \
    wireguard-tools \
    wl-clipboard

set -l c_packages \
    bear \
    clang \
    cmake \
    gtk4 \
    meson

set -l emacs_packages \
    emacs-wayland \
    ispell \
    shfmt

sudo pacman -S --needed --noconfirm \
    $main_packages $c_packages $emacs_packages

sudo systemctl enable --now \
    bluetooth \
    power-profiles-daemon

sudo pacman -Rns \
    gnome-extensions \
    gnome-maps \
    gnome-music \
    gnome-system-monitor \
    gnome-tour \
    htop
