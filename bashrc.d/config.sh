#!/usr/bin/env bash

################################################################################
# Global Variables
################################################################################

FONTS="$HOME/.fonts"
ICONS="$HOME/.icons"
SYSTEM_CONFIG="$HOME/Developer/system-config"
THEMES="$HOME/.themes"

################################################################################
# Starship
################################################################################

if command -v bat >/dev/null 2>&1; then
	eval "$(starship init bash)"
else
	echo "Don't forget to install Starship!"
fi

################################################################################
# SSH Key
################################################################################

# Start ssh-agent if it isn't running and add ssh key
# Reset ssh key password: `ssh-keygen -p -f ~/.ssh/id_ed25519`
if [ -z "$SSH_AUTH_SOCK" ]; then
	eval "$(ssh-agent -s)" > /dev/null
fi
SSH_KEY="$HOME/.ssh/id_ed25519"
if [ -f "$SSH_KEY" ]; then
	ssh-add "$SSH_KEY" 2>/dev/null
fi

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
    echo "Bash config reloaded! 🐧"
}

alias vi="nvim"

update() {
	if command -v apt >/dev/null 2>&1; then
		echo -e "\nUPDATING APT"
		sudo apt update
		sudo apt dist-upgrade -y
		sudo apt autoremove -y
	fi

	if command -v dnf >/dev/null 2>&1; then
        echo -e "\nUPDATING DNF"
        sudo dnf update -y
        sudo dnf autoremove -y
	fi

	if command -v flatpak >/dev/null 2>&1; then
        echo -e "\nUPDATING FLATPAK"
        sudo flatpak update -y
	fi

    echo -e "\nDONE"
}

alias up="update"
