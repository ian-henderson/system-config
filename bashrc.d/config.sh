#!/usr/bin/env bash

################################################################################
# Global Variables
################################################################################

export DOCKER_COMPOSE="$HOME/DockerCompose"
export FONTS="$HOME/.fonts"
export ICONS="$HOME/.icons"
export SSH_KEY="$HOME/.ssh/id_ed25519"
export SYSTEM_CONFIG="$HOME/Developer/system-config"
export THEMES="$HOME/.themes"
# FLATPAK_DIR="/var/lib/flatpak/exports/share"
# export XDG_DATA_DIRS="${XDG_DATA_DIRS:+$XDG_DATA_DIRS:}$FLATPAK_DIR"
# export XDG_DATA_HOME="${XDG_DATA_HOME:+$XDG_DATA_HOME:}$FLATPAK_DIR"

################################################################################
# Starship
# https://starship.rs/guide
################################################################################

if command -v starship >/dev/null 2>&1; then
	if ! [ -f "~/.config/starship.toml" ]; then
		starship preset plain-text-symbols -o ~/.config/starship.toml
	fi
	eval "$(starship init bash)"
else
	echo "Don't forget to install Starship!"
fi

################################################################################
# ble.sh
# https://github.com/akinomyoga/ble.sh
################################################################################

blesh_source() {
	source "$HOME/.local/share/blesh/ble.sh" \
		   --attach=none \
		   --rcfile "$HOME/.config/blerc"

	[ -n "${BLE_VERSION-}" ] && ble-attach
}

blesh_install_latest() {
	echo "Installing ble.sh..."
	curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar xJf -

	bash ble-nightly/ble.sh --install ~/.local/share

	rm -rf ble-nightly
}

[ -d "$HOME/.local/share/blesh" ] || blesh_install_latest

blesh_source

################################################################################
# SSH Key
################################################################################

# Start ssh-agent if it isn't running and add ssh key
# Reset ssh key password: `ssh-keygen -p -f ~/.ssh/id_ed25519`
[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)" > /dev/null
[ -f "$SSH_KEY" ] && ssh-add "$SSH_KEY" 2>/dev/null

################################################################################
# Aliases/Functions
################################################################################

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

cat() {
	local bin=""

	if command -v bat >/dev/null 2>&1; then
		bin="bat"
	elif command -v batcat >/dev/null 2>&1; then
		bin="batcat"
	else
		command cat "$@"
		return 0
	fi

	"$bin" -pp --tabs 4 --theme ansi "$@"
}

em() {
	emacsclient -ct "$@"
}

alias ff="fastfetch"

fflol() {
	if ! command -v lolcat >/dev/null 2>&1; then
		echo "fflol: lolcat not installed."
		return 127
	fi

	fastfetch "$@" | lolcat
}

alias g="git"

alias ls="ls --color=auto --group-directories-first -h"
alias ll="ls -l"
alias l="ll"
alias la="ls -A"
alias lt="ls -ltr"

reload() {
	source "$HOME/.bashrc"
    echo -e "\n\n\nBash config reloaded! 🐧\n"
}

alias vi="nvim"

update_docker_images() {
	if [ ! -d "$DOCKER_COMPOSE" ]; then
		echo "DockerCompose directory doesn't exist. Exiting."
		return 1
	fi

	(
		cd "$DOCKER_COMPOSE" || exit

		for dir in */; do
			(
				cd "$dir" || exit

				image=$(basename "$dir")

				if [ ! -f "docker-compose.yaml" ] \
					   && [ ! -f "docker-compose.yml" ]; then
					echo "$image is missing docker-compose file. Skipping."
					exit
				fi

				if sudo docker compose pull	&& sudo docker compose up -d; then
					sudo docker image prune -f
					echo "Successfully updated $image"
				else
					echo "Failed to update $image" >&2
				fi
			)
		done
	)
}

update() {
	if command -v apt >/dev/null 2>&1; then
		echo -e "\nUPDATING APT\n"
		sudo apt update
		sudo apt dist-upgrade
		sudo apt autoremove -y
	fi

	if command -v dnf >/dev/null 2>&1; then
        echo -e "\nUPDATING DNF\n"
        sudo dnf update
        sudo dnf autoremove -y
	fi

	if [ -d "$DOCKER_COMPOSE" ] \
		   && command -v update_docker_images >/dev/null 2>&1; then
		echo -e "\nUPDATING DOCKER IMAGES\n"
		update_docker_images
	fi

	if command -v flatpak >/dev/null 2>&1; then
        echo -e "\nUPDATING FLATPAK\n"
        sudo flatpak update
	fi

    echo -e "\nDONE\n"
}

alias up="update"

check_website_dns() {
	echo -e "\nwww.ianhenderson.info CNAME:"
	dig www.ianhenderson.info CNAME +short

	echo -e "\nGitHub Pages TXT:"
	dig _github-pages-challenge-ian-henderson.ianhenderson.info TXT +short
}
