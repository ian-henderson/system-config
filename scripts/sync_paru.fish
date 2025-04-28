#!/usr/bin/env fish

# https://github.com/Morganamilo/paru

set -l initial_pwd "$PWD"
set -l developer_dir "$HOME/Developer"
set -l paru_dir "$developer_dir/paru"

mkdir -p "$developer_dir"

sudo pacman -S --needed base-devel

if test -d "$paru_dir/.git"
    echo "Updating paru..."
    cd "$paru_dir"
    git pull
else
    echo "Cloning paru..."
    git clone https://aur.archlinux.org/paru.git "$paru_dir"
    cd "$paru_dir"
end

makepkg -si

cd "$initial_pwd"

paru -Sy \
    1password \
    brave-bin
