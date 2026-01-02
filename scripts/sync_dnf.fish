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

install_vscode

set -l main_packages \
    bat \
    btop \
    code \
    fastfetch \
    gnome-chess \
    gnome-tweaks \
    htop \
    lolcat \
    neovim

set -l c_packages \
    cmake \
    clang \
    clang-devel

set -l docker_packages \
    dnf-plugins-core

set -l emacs_packages \
    emacs \
    libtool

set -l font_packages \
    adobe-source-sans-pro-fonts \
    cascadia-code-fonts \
    dejavu-fonts-all \
    google-go-mono-fonts \
    google-roboto-fonts \
    google-roboto-mono-fonts \
    ibm-plex-fonts-all \
    jetbrains-mono-fonts \
    liberation-fonts-all \
    source-foundry-hack-fonts

set -l java_packages \
    java-21-openjdk

set -l python_packages \
    conda

sudo dnf install -y \
    $main_packages \
    $c_packages \
    $docker_packages \
    $emacs_packages \
    $font_packages \
    $java_packages \
    $python_packages

sudo dnf remove -y \
    evince \
    firefox \
    gnome-boxes \
    gnome-clocks \
    gnome-contacts \
    gnome-maps \
    gnome-tour \
    libreoffice-core \
    rhythmbox \
    yelp

# docker
sudo dnf-3 config-manager --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin
