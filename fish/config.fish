# https://fishshell.com/docs/current/index.html

# PLUGINS:
# - Fisher Package Manager: https://github.com/jorgebucaran/fisher
# - nvm.fish: https://github.com/jorgebucaran/nvm.fish

set -l fish_dir "$HOME/.config/fish"

if test -f "$fish_dir/secrets.fish"
    source "$fish_dir/secrets.fish"
end

set -x PHP_CS_FIXER_IGNORE_ENV 1
set -x PKG_CONFIG_PATH /usr/lib/pkgconfig
set -x -a XDG_DATA_DIRS /var/lib/flatpak/exports/share

fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.composer/vendor/bin"
fish_add_path "$HOME/.local/share/nvm/v24.1.0/bin"


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

    if test -f /opt/miniconda3/bin/conda
        eval /opt/miniconda3/bin/conda "shell.fish" hook $argv | source
    else
        if test -f "/opt/miniconda3/etc/fish/conf.d/conda.fish"
            . "/opt/miniconda3/etc/fish/conf.d/conda.fish"
        else
            set -x PATH /opt/miniconda3/bin $PATH
        end
    end
end
