#!/usr/bin/env fish

function add_brave_repo
    sudo apt install curl -y

    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
        https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" |
        sudo tee /etc/apt/sources.list.d/brave-browser-release.list
end

function add_1password_repo
    curl -sS https://downloads.1password.com/linux/keys/1password.asc \
        | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg

    echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' \
        | sudo tee /etc/apt/sources.list.d/1password.list

    sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/

    curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol \
        | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol

    sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22

    curl -sS https://downloads.1password.com/linux/keys/1password.asc \
        | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
end

add_brave_repo

add_1password_repo

sudo apt update -y

sudo apt dist-upgrade -y

sudo apt install -y \
    bat \
    brave-browser \
    btop \
    curl \
    fastfetch \
    fish \
    git \
    lolcat \
    neovim \
    thunderbird \
    tree \
    wget \
    wl-clipboard

# Rust-specific packages
sudo apt install -y \
    gcc \
    libssl-dev \
    pkg-config

# Guile packages
sudo apt install -y \
    guile-3.0 \
    guile-3.0-dev

# Emacs packages
sudo apt install -y \
    clang-format \
    cmake \
    emacs-common-non-dfsg \
    emacs-gtk \
    gcc \
    libvterm-dev \
    make \
    pkg-config \
    shfmt
