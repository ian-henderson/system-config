#!/usr/bin/env bash

echo "SYNCHRONIZING PARU"

dev_dir="$HOME/Developer"

mkdir -p "$dev_dir" || {
	echo "Error: Failed to make dir: $dev_dir. Exiting."
	exit 1
}

cd "$dev_dir" || {
	echo "Error: Failed to cd to dir: $dev_dir. Exiting."
	exit 1
}

sudo pacman -S --needed --noconfirm base-devel

paru_dir="$dev_dir/paru"

if [ -d "$paru_dir" ]; then
	echo "Checking for paru changes"
	cd "$paru_dir"
	before=$(git rev-parse HEAD)
	git pull
	after=$(git rev-parse HEAD)
	if [ "$before" != "$after" ]; then
		echo "New changes were pulled"
		makepkg -si
	else
		echo "No changes"
	fi
else
	git clone https://aur.archlinux.org/paru.git "$paru_dir"
	cd "$paru_dir"
	makepkg -si
fi
