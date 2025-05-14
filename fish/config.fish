# https://fishshell.com/docs/current/index.html

set -l fish_dir "$HOME/.config/fish"

if test -f "$fish_dir/secrets.fish"
    source "$fish_dir/secrets.fish"
end

set -x PKG_CONFIG_PATH /usr/lib/pkgconfig

if status is-interactive
    set -x CONFIG "$HOME/.config"
    set -x EDITOR nvim
    set -x FONTS "$HOME/.fonts"
    set -x ICONS "$HOME/.icons"
    set -x THEMES "$HOME/.themes"

    if test -d "$fish_dir/functions"
        for file in $fish_dir/functions/*.fish
            source "$file"
        end
    end
end
