#!/bin/bash

parent_dir=".."

home_dotfiles=(
	"bash_profile"
	"bashrc"
	"bashrc.d"
	"emacs.d"
	"gitconfig"
	"inputrc"
)

for f in "${home_dotfiles[@]}"; do
	source_file="$parent_dir/$f"
	target_file="$HOME/.$f"

	if [[ -f "$target_file" ]] || [[ -L "$target_file" ]]; then
		rm -rf "$target_file"
	fi

	if [[ -e "$source_file" ]]; then
		ln -s "$source_file" "$target_file"
	fi
done

config="$HOME/.config"

if [[ ! -d "$config" ]]; then
	mkdir -p "$config"
fi

config_dirs=(
	"fastfetch"
	"nvim"
)

for d in "${config_dirs[@]}"; do
	source_dir="$parent_dir/$d"
	target_dir="$config/$d"

	if [[ -d "$target_dir" ]] || [[ -L "$target_dir" ]]; then
		rm -rf "$target_dir"
	fi

	if [[ -e "$source_dir" ]]; then
		ln -s "$source_dir" "$target_dir"
	fi
done
