#!/usr/bin/env fish

sudo pacman -Syyu

set -l main_packages \
    bat \
    btop \
    docker \
    docker-compose \
    fastfetch \
    git \
    gnome-builder \
    htop \
    lolcat \
    man-db \
    neovim \
    power-profiles-daemon \
    timeshift \
    tree \
    ttf-input \
    ttf-liberation \
    wireguard-tools \
    wl-clipboard \
    yaru-gnome-shell-theme \
    yaru-gtk-theme \
    yaru-icon-theme

set -l c_dev_packages \
    bear \
    ccls \
    clang \
    cmake \
    cunit \
    flatpak-builder \
    gdb \
    gtk4 \
    meson

set -l emacs_packages \
    emacs-wayland \
    ispell \
    shfmt

set -l php_packages \
    composer \
    phpactor \
    php-sqlite \
    sqlite

sudo pacman -S --needed --noconfirm \
    $main_packages $c_dev_packages $emacs_packages $php_packages

sudo systemctl enable --now \
    bluetooth \
    power-profiles-daemon

sudo pacman -Rns \
    gnome-extensions \
    gnome-maps \
    gnome-music \
    gnome-system-monitor \
    gnome-tour
