#!/usr/bin/env bash

create_symbolic_link() {
    local src="$1"
    local target="$2"

    if [ ! -e "$src" ]; then
        echo "$src does not exist. Skipping."
        return
    fi

    if [ -e "$target" ]; then
        if [ -L "$target" ]; then
            rm "$target"
            echo "Removed old symbolic link $target"
        else
            local target_backup="$target.backup.$(date +%s)"
            mv "$target" "$target_backup"
            echo "Backed up $target to $target_backup"
        fi
    fi

    ln -s "$src" "$target"
    echo "Symbolically linked $src -> $target"
}

# Configuration Directories
SCRIPT_DIR="$HOME/Developer/system-config"
HOME_DOTFILES=(
	"bashrc"
	"bashrc.d"
	"clang-format"
	"emacs.d"
	"gitconfig"
	"inputrc"
)

# Link Home Dotfiles
for i in "${HOME_DOTFILES[@]}"; do
    src="$SCRIPT_DIR/$i"
    target="$HOME/.$i"
    create_symbolic_link "$src" "$target"
done

# Special handling for legacy .emacs file
if [ -e "$HOME/.emacs" ]; then
    rm "$HOME/.emacs"
fi

# Ensure .config exists
CONFIG_DIR="$HOME/.config"
if [ ! -d "$CONFIG_DIR" ]; then
    mkdir -p "$CONFIG_DIR"
fi

# Link Config Directories
CONFIG_DIRS=("fastfetch" "nvim")
for i in "${CONFIG_DIRS[@]}"; do
    src="$SCRIPT_DIR/$i"
    target="$CONFIG_DIR/$i"
    create_symbolic_link "$src" "$target"
done
