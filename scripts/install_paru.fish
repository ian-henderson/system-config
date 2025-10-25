#!/usr/bin/env fish

if ! type -q pacman
	echo "Not on an Arch system (pacman not found). Exiting."
	exit 1
end

if type -q paru
	echo "Paru already installed. Exiting."
	exit 0
end

if ! type -q git
	echo "Git not found. Installing..."
	sudo pacman -S git --noconfirm
end

sudo pacman -S --needed base-devel

mkdir -p ~/Developer

set -l paru_dir ~/Developer/paru

if test -d $paru_dir
	cd $paru_dir
	git pull
else
	git clone https://aur.archlinux.org/paru.git $paru_dir
	cd $paru_dir
end

makepkg -si

cd -
