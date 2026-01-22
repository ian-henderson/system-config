#!/usr/bin/env bash

# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

SSH_KEY="$HOME/.ssh/id_ed25519"

echo "Generating ssh key and copying public key to clipboard..."

# TODO rethink logic

copy_public_key_to_clipboard() {
	if ! command -v wl-copy >/dev/null 2>&1; then
		echo "wl-copy not installed. Skipping copy to clipboard."
		return 1
	fi

    if ! [ -f "$SSH_KEY.pub" ]; then
        echo "Public key file not found. Skipping copy to clipboard."
		return 1
	fi

	cat "$SSH_KEY.pub" | wl-copy
	echo "Copied public key to clipboard."
}

if [ -f "$SSH_KEY" ]; then
    copy_public_key_to_clipboard
    echo "ssh key ($SSH_KEY) already exists. Exiting."
    exit 0
fi

ssh-keygen -t ed25519 -C "ianhenderson@pm.me" -f "$SSH_KEY"

eval "$(ssh-agent -s)"

ssh-add "$SSH_KEY"

copy_public_key_to_clipboard
