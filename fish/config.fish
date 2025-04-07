# https://fishshell.com/docs/current/index.html

set fish_dir ~/.config/fish

if test -f $fish_dir/secrets.fish
    source $fish_dir/secrets.fish
end

fish_add_path ~/.cargo/bin

if status is-interactive
    set -x EDITOR nvim
    set -x FONTS ~/.fonts
    set -x ICONS ~/.icons
    set -x THEMES ~/.themes

    for file in $fish_dir/functions/*.fish
        source $file
    end
end
