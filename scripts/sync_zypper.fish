#!/usr/bin/env fish

# enable fractional scaling
gsettings set org.gnome.mutter experimental-features \
    "['scale-monitor-framebuffer', 'xwayland-native-scaling']"

# add brave repo
sudo zypper addrepo \
    https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

# add 1password repo
sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
sudo zypper addrepo \
    https://downloads.1password.com/linux/rpm/stable/x86_64 1password

sudo zypper refresh
sudo zypper update -y
sudo zypper dist-upgrade -y

sudo zypper install -y \
    1password \
    alsa-firmware \
    bat \
    brave-browser \
    btop \
    fastfetch \
    git-core \
    gnome-shell-theme-yaru \
    gnome-tweaks \
    guile-devel \
    neovim \
    papirus-icon-theme \
    power-profiles-daemon \
    sof-firmware \
    thunderbird

# emacs
sudo zypper install -y \
    clang-tools \
    emacs \
    ispell \
    shfmt

sudo zypper remove -y \
    cheese \
    evolution \
    gimp \
    gnome-chess \
    gnome-extensions \
    gnome-mahjongg \
    gnome-maps \
    gnome-mines \
    gnome-music \
    gnome-remote-desktop \
    gnome-sudoku \
    gnome-system-monitor \
    libreoffice \
    lightsoff \
    MozillaFirefox \
    opensuse-welcome \
    polari \
    quadrapassel \
    swell-foop \
    transmission-gtk \
    xscreensaver \
    xterm \
    yast2-scanner \
    yelp
