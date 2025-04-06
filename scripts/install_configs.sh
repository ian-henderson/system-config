#!/bin/bash

parent_dir="$PWD/.."

home_dotfiles=(
	"bash_profile"
	"bashrc"
	"bashrc.d"
	"emacs.d"
	"gitconfig"
	"inputrc"
)

for f in "${home_dotfiles[@]}"; do
	src="$parent_dir/$f"
	target="$HOME/.$f"

	if [[ -f "$target" ]] || [[ -L "$target" ]]; then
		rm -rf "$target"
	fi

	if [[ -e "$src" ]]; then
		ln -s "$src" "$target"
	fi
done

config="$HOME/.config"

if [[ ! -d "$config" ]]; then
	mkdir -p "$config"
fi

config_dirs=(
	"fastfetch"
	"fish"
	"nvim"
)

for d in "${config_dirs[@]}"; do
	src="$parent_dir/$d"
	target="$config/$d"

	if [[ -d "$target" ]] || [[ -L "$target" ]]; then
		rm -rf "$target"
	fi

	if [[ -e "$src" ]]; then
		ln -s "$src" "$target"
	fi
done
