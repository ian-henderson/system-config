#!/usr/bin/env fish

./sync_apt_common.fish

sudo apt install -y flatpak

sudo apt autoremove --purge -y \
    evolution \
    firefox-esr \
    gnome-games \
    gnome-maps \
    gnome-music \
    gnome-system-monitor \
    gnome-tour \
    lightsoff \
    malcontent \
    quadrapassel \
    rhythmbox \
    shotwell \
    swell-foop \
    tali \
    yelp
