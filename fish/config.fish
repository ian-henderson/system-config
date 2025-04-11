# https://fishshell.com/docs/current/index.html

set fish_dir "$HOME/.config/fish"

if test -f "$fish_dir/secrets.fish"
    source "$fish_dir/secrets.fish"
end

if test -d "$HOME/.cargo/bin"
    fish_add_path "$HOME/.cargo/bin"
end

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
