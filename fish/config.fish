# https://fishshell.com/docs/current/index.html

set -l fish_dir "$HOME/.config/fish"

if test -f "$fish_dir/secrets.fish"
    source "$fish_dir/secrets.fish"
end

set -x PHP_CS_FIXER_IGNORE_ENV 1
set -x PKG_CONFIG_PATH /usr/lib/pkgconfig
set -x -a XDG_DATA_DIRS /var/lib/flatpak/exports/share
set -x SSH_KEY ~/.ssh/id_ed25519

fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.composer/vendor/bin"
fish_add_path "$HOME/.local/share/nvm/v24.1.0/bin"

if status is-interactive
    set -x CONFIG "$HOME/.config"
    set -x EDITOR nvim
    set -x FONTS "$HOME/.fonts"
    set -x ICONS "$HOME/.icons"
    set -x THEMES "$HOME/.themes"

    # Check if agent is responding; start a new one if not
    if not ssh-add -l > /dev/null 2>&1

	# Clean up orphaned agent processes
	pkill -u $USER ssh-agent > /dev/null 2>&1

	# Start a new agent
	eval (ssh-agent -c) > /dev/null

	# Set global exported variables
	set -gx SSH_AGENT_PID $SSH_AGENT_PID
	set -gx SSH_AUTH_SOCK $SSH_AUTH_SOCK

	# Prompt to add default key if agent is empty
	if test -f $SSH_KEY
	    ssh-add $SSH_KEY > /dev/null 2>&1
	end
    end

    if test -d "$fish_dir/functions"
	for file in $fish_dir/functions/*.fish
	    source "$file"
	end
    end
end
