#!/usr/bin/env fish

sudo pacman -Syyu

sudo pacman -S \
    bat \
    btop \
    fastfetch \
    git \
    man-db \
    neovim \
    power-profiles-daemon \
    thunderbird \
    wl-clipboard

# ttf-font options: gnu-free-fonts, noto-fonts, ttf-bitstream-vera, ttf-croscore
#                   ttf-dejavu, ttf-droid, ttf-ibm-plex, ttf-input,
#                   ttf-input-nerd, ttf-liberation, ttf-roboto
sudo pacman -S \
    ttf-dejavu \
    ttf-hack-nerd \
    ttf-liberation

sudo systemctl enable --now power-profiles-daemon

# Emacs
sudo pacman -S \
    cmake \
    emacs-wayland \
    ispell \
    shfmt

sudo pacman -Rns \
    epiphany \
    gnome-extensions \
    gnome-maps \
    gnome-music \
    gnome-system-monitor \
    gnome-tour \
    htop
