#!/usr/bin/env bash

main_packages=(
	bat
	btop
	emacs-wayland
	htop
	less # git diff
	lolcat
	neovim
	pngquant
	rustup # paru
	starship
	wl-clipboard
	yt-dlp
)

c_packages=(
	make
	cmake
)

# TODO: find conda package (python)

sudo pacman -Syu
sudo pacman -S --needed --noconfirm \
	 "${main_packages[@]}" \
	 "${c_packages[@]}"

# Rustup
rustup default stable

# Paru
(
	dev_dir="$HOME/Developer"
	mkdir -p "$dev_dir" || {
		echo "Error: Failed to make dir: $dev_dir. Exiting."
		exit 1
	}
	cd "$dev_dir" || {
		echo "Error: Failed to cd to dir: $dev_dir. Exiting."
		exit 1
	}
	paru_dir="$dev_dir/paru"
	sudo pacman -S --needed --noconfirm base-devel
	if [ -d "$paru_dir" ]; then
		cd "$paru_dir"
		before=$(git rev-parse HEAD)
		git pull
		after=$(git rev-parse HEAD)
		if [ "$before" != "$after" ]; then
			echo "New changes were pulled"
			make -si
		else
			echo "No changes"
		fi
	else
		git clone https://aur.archlinux.org/paru.git "$paru_dir"
		cd "$paru_dir"
		make -si
	fi
)

if command -v paru >/dev/null 2>&1; then
	paru_packages=(
		vscodium-bin
	)
	paru -S --needed --noconfirm "${paru_packages[@]}"
fi

packages_to_remove=(
	elisa
	okular
)
for package in "${packages_to_remove[@]}"; do
    if pacman -Q "$package" >/dev/null 2>&1; then
        echo "Removing $package..."
        sudo dnf remove -y "$package"
    fi
done
