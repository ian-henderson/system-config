#!/usr/bin/env fish

# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

set ssh_key ~/.ssh/id_ed25519

echo "Generating ssh key and copying public key to clipboard..."

function copy_public_key_to_clipboard
	if ! type -q wl-copy
		echo "Installing wl-clipboard to copy public key to clipboard..."
		sudo pacman -S wl-clipboard --noconfirm
	end
	cat "$ssh_key.pub" | wl-copy
	echo "Copied public key to clipboard."
end

if test -f $ssh_key
	copy_public_key_to_clipboard
	echo "ssh key ($ssh_key) already exists. Exiting."
	exit
end

ssh-keygen -t ed25519 -C "ianhenderson@pm.me"

eval (ssh-agent -c)

ssh-add $ssh_key

copy_public_key_to_clipboard

