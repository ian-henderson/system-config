#!/usr/bin/env fish

./sync_apt_common.fish

if not -q protonmail-bridge
    wget -O protonmail-bridge.deb \
        https://proton.me/download/bridge/protonmail-bridge_3.19.0-1_amd64.deb
    sudo apt install ./protonmail-bridge.deb
    rm ./protonmail-bridge.deb
end

sudo apt install -y \
    dconf-editor \
    gnome-boxes \
    gnome-shell-extension-manager \
    gnome-tweaks \
    ptyxis

sudo snap install -y \
    discord \
    foliate \
    gimp \
    gnome-weather \
    mission-center \
    shortwave \
    signal-desktop \
    zoom-client
