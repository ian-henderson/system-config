#!/usr/bin/env bash

# Starship COPR
sudo dnf copr enable atim/starship

main_packages=(
    bat
    btop
    fastfetch
    htop
    lolcat
    neovim
	starship
)

c_packages=(
    cmake
    clang
    clang-devel
)

emacs_packages=(
    emacs
    libtool
)

sudo dnf install -y \
    "${main_packages[@]}" \
    "${c_packages[@]}" \
    "${emacs_packages[@]}"

packages_to_remove=(
    firefox
    libreoffice-core
    rhythmbox
    yelp
)

for package in "${packages_to_remove[@]}"; do
    if dnf list --installed "$package" >/dev/null 2>&1; then
        echo "Removing $package..."
        sudo dnf remove -y "$package"
    else
        echo "$package isn't installed. Skipping."
    fi
done

# RPM Fusion Configuration
if ! dnf repolist | grep -q rpmfusion-free; then
    sudo dnf install -y "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
fi

if ! dnf repolist | grep -q rpmfusion-nonfree; then
    sudo dnf install -y "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
fi

sudo dnf config-manager --set-enabled fedora-cisco-openh264
# switch to full ffmpeg
sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y
# additional codec
sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
# intel codec
sudo dnf install intel-media-driver -y

# Brave Browser installation
if command -v brave-browser >/dev/null 2>&1; then
    echo "Brave is installed."
else
    sudo dnf install -y dnf-plugins-core
    sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
    sudo dnf install -y brave-browser
fi
