#!/usr/bin/env bash

sync_fastfetch() {
	local compile_needed=1
	local fastfetch_dir="$HOME/Developer/fastfetch"
	local init_dir="$PWD"

	if [ -d "$fastfetch_dir" ]; then
		echo "Updating Fastfetch..."
		cd "$fastfetch_dir"

		OLD_HEAD=$(git rev-parse HEAD)
		git pull
		NEW_HEAD=$(git rev-parse HEAD)

		if [ "$OLD_HEAD" = "$NEW_HEAD" ]; then
			compile_needed=0
			echo "Fastfetch already up to date."
		fi
	else
		echo "Installing Fastfetch..."
		mkdir -p "$HOME/Developer"
		git clone \
			https://github.com/fastfetch-cli/fastfetch.git \
			"$fastfetch_dir"
		cd "$fastfetch_dir" || return 1
	fi

	if [ "$compile_needed" -eq 1 ]; then
		echo "Compiling and installing Fastfetch..."
		bash ./run.sh
		sudo cp ./build/fastfetch /usr/local/bin
		echo "Installed Fastfetch!"
	fi

	cd "$init_dir" || return 1
}

sync_fastfetch
