#!/usr/bin/env fish

function create-symbolic-link
    set -l src $argv[1]
    set -l target $argv[2]

    if not test -e "$src"
        echo "$src does not exist. Skipping."
        return
    end

    if test -e "$target"
        if test -L "$target"
            rm "$target"
            echo "Removed old symbolic link $target"
        else
            set target_backup "$target.backup."(date +%s)
            mv "$target" "$target_backup"
            echo "Backed up $target to $target_backup"
        end
    end

    ln -s "$src" "$target"
    echo "Symbolically linked $src -> $target"
end

set script_dir "$HOME/Developer/system-config"

set home_dotfiles "emacs.d" gitconfig

for i in $home_dotfiles
    set src "$script_dir/$i"
    set target "$HOME/.$i"
    create-symbolic-link "$src" "$target"
end

if test -e "$HOME/.emacs"
    rm "$HOME/.emacs"
end

set config "$HOME/.config"

if not test -d "$config"
    mkdir -p "$config"
end

set config_dirs fastfetch fish nvim

for i in $config_dirs
    set src "$script_dir/$i"
    set target "$config/$i"
    create-symbolic-link "$src" "$target"
end
