#!/usr/bin/env bash

# https://ohmybash.nntoan.com/

echo "Initializing Oh My Bash"

# check to see if Oh My Bash is installed
if [ -d "$OSH" ] || [ -n "$OSH" ]; then
	echo "Oh My Bash is already installed. Skipping installation."
else
	echo "Installing Oh My Bash..."
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
fi

source_command=". ~/Developer/system-config/bashrc"
if ! grep -Fxq "$source_command" ~/.bashrc; then
	echo "Appending source command to ~/.bashrc"
	echo -e "\n$source_command" >> ~/.bashrc
fi
