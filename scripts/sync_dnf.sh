#!/usr/bin/env bash

# Starship COPR
sudo dnf copr enable atim/starship

dnf_repos=$(sudo dnf repolist)

# Docker
if [[ ! "$dnf_repos" =~ "docker-ce-stable" ]]; then
	sudo dnf config-manager addrepo --from-repofile \
		 https://download.docker.com/linux/fedora/docker-ce.repo
fi

# RPM Fusion Configuration
if [[ ! "$dnf_repos" =~ "rpmfusion-free" ]]; then
    sudo dnf install -y "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
fi
if [[ ! "$dnf_repos" =~ "rpmfusion-nonfree" ]]; then
    sudo dnf install -y "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
fi

# VSCodium Repo
if [[ ! "$dnf_repos" =~ "gitlab.com_paulcarroty_vscodium_repo" ]]; then
	sudo tee -a /etc/yum.repos.d/vscodium.repo << 'EOF'
[gitlab.com_paulcarroty_vscodium_repo]
name=gitlab.com_paulcarroty_vscodium_repo
baseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg
metadata_expire=1h
EOF
fi

main_packages=(
    bat
    btop
	codium
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

docker_packages=(
	docker-ce
	docker-ce-cli
	containerd.io
	docker-buildx-plugin
	docker-compose-plugin
)

python_packages=(
	conda
)

sudo dnf install -y \
    "${main_packages[@]}" \
    "${c_packages[@]}" \
    "${docker_packages[@]}" \
    "${emacs_packages[@]}" \
	"${python_packages[@]}"

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

# post-installation fedora set-up
sudo dnf config-manager --set-enabled fedora-cisco-openh264
# switch to full ffmpeg
sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y
# additional codec
sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
# intel codec
sudo dnf install intel-media-driver -y

# docker set-up
sudo systemctl enable --now docker
# enables docker to be used without sudo
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
