#!/usr/bin/env fish

set parent_dir "$PWD/.."

set home_dotfiles "emacs.d" gitconfig

for element in $home_dotfiles
    set src "$parent_dir/$element"
    set target "$HOME/.$element"

    if test -e "$target"
        rm -rf "$target"
    end

    if test -e "$src"
        ln -s "$src" "$target"
    end
end

set config "$HOME/.config"

if not test -d "$config"
    mkdir -p "$config"
end

set config_dirs fastfetch fish nvim

for element in $config_dirs
    set src "$parent_dir/$element"
    set target "$config/$element"

    if test -e "$target"
        rm -rf "$target"
    end

    if test -e "$src"
        ln -s "$src" "$target"
    end
end
