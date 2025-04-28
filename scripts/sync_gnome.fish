#!/usr/bin/env fish

gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true

# enable fractional scaling
gsettings set org.gnome.mutter experimental-features \
    "['scale-monitor-framebuffer', 'xwayland-native-scaling']"
