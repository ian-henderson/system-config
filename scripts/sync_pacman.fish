#!/usr/bin/env fish

sudo pacman -Syyu

set -l main_packages \
    bat \
    btop \
    fastfetch \
    git \
    gnome-builder \
    htop \
    lolcat \
    man-db \
    neovim \
    power-profiles-daemon \
    proton-pass-bin \
    timeshift \
    tree \
    ttf-liberation \
    ttf-roboto \
    ttf-roboto-mono \
    ttf-roboto-serif \
    wireguard-tools \
    wl-clipboard

set -l c_dev_packages \
    bear \
    ccls \
    clang \
    cmake \
    flatpak-builder \
    gdb \
    gtk4 \
    meson

set -l emacs_packages \
    emacs-wayland \
    ispell \
    shfmt

sudo pacman -S --needed --noconfirm \
    $main_packages $c_dev_packages $emacs_packages

sudo systemctl enable --now \
    bluetooth \
    power-profiles-daemon

sudo pacman -Rns \
    gnome-extensions \
    gnome-maps \
    gnome-music \
    gnome-system-monitor \
    gnome-tour
