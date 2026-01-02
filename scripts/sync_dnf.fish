#!/usr/bin/env fish

# vscode
function install_vscode
    if type -q code
        echo "vscode is already installed."
        return
    end

    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" \
        | sudo tee /etc/yum.repos.d/vscode.repo >/dev/null
    dnf check-update
end

set -l main_packages \
    bat \
    btop \
    code \
    fastfetch \
    htop \
    lolcat \
    neovim

set -l c_packages \
    cmake \
    clang \
    clang-devel

set -l emacs_packages \
    emacs \
    libtool

sudo dnf install -y \
    $main_packages \
    $c_packages \
    $emacs_packages

set -l packages_to_remove \
    firefox \
    libreoffice-core \
    rhythmbox \
    yelp

for package in $packages_to_remove
    if dnf list --installed $package >/dev/null 2>&1
        echo "Removing $package..."
        sudo dnf remove -y $package
    else
        echo "$package isn't installed. Skipping."
    end
end
