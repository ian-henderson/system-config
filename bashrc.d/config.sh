#!/usr/bin/env bash

################################################################################
# Global Variables
################################################################################

export DOCKER_COMPOSE="$HOME/DockerCompose"
export EDITOR="emacsclient -c"
export FONTS="$HOME/.fonts"
export ICONS="$HOME/.icons"
export SSH_KEY="$HOME/.ssh/id_ed25519"
export SYSTEM_CONFIG="$HOME/Developer/system-config"
export THEMES="$HOME/.themes"

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

ff() {
	fastfetch --logo Guix_small "$@"
}

fflol() {
	if ! command -v lolcat >/dev/null 2>&1; then
		echo "fflol: lolcat not installed."
		return 127
	fi

	ff "$@" | lolcat
}

alias g="git"

alias ls="ls --color=auto --group-directories-first -h"
alias ll="ls -l"
alias l="ll"
alias la="ls -A"
alias lt="ls -ltr"

reload() {
	source "$HOME/.bashrc"
    echo "Bash config reloaded! 🐧"
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

				local image=$(basename "$dir")

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
	if command -v guix >/dev/null 2>&1; then
		echo -e "\nUPDATING GUIX\n"
		echo "TODO: write this function"
	fi

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

	if command -v pacman >/dev/null 2>&1; then
		if command -v paru >/dev/null 2>&1; then
			echo -e "\nUPDATING PARU\n"
			paru -Syu
		else
			echo -e "\nUPDATING PACMAN\n"
			sudo pacman -Syu
		fi
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

enable_gnome_fractional_scaling() {
	if ! command -v gsettings >/dev/null 2>&1; then
		echo "Error: gsettings isn't installed. Exiting."
		return 1
	fi

	gsettings set org.gnome.mutter experimental-features \
			  "['scale-monitor-framebuffer']"
}

check_website_dns() {
	if ! command -v dig >/dev/null 2>&1; then
		echo "Error: dig isn't installed. Exiting."
		return 1
	fi

	echo -e "\nwww.ianhenderson.info CNAME:"
	dig www.ianhenderson.info CNAME +short

	echo -e "\nGitHub Pages TXT:"
	dig _github-pages-challenge-ian-henderson.ianhenderson.info TXT +short
}

yt_dlp_audio() {
	if ! command -v yt-dlp >/dev/null 2>&1; then
		echo "Error: yt-dlp isn't installed. Exiting."
		return 1
	fi

	if [ -z "$1" ]; then
		echo "Error: YouTube video id argument required. Exiting."
		return 1
	fi

	(
		yt_dlp_dir="$HOME/Music/yt-dlp"

		mkdir -p "$yt_dlp_dir" || {
			echo "Failed to create directory $yt_dlp_dir. Exiting."
			return 1
		}

		cd "$yt_dlp_dir" || {
			echo "Failed to cd to $yt_dlp_dir. Exiting."
			return 1
		}

		yt-dlp "$1" \
			   --embed-metadata \
			   --embed-thumbnail \
			   --extract-audio \
			   --audio-quality 0 \
			   --output "%(channel)s/%(title)s.%(ext)s"
	)
}
