#!/usr/bin/env fish

# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

if not set -q SSH_KEY
    echo "\$SSH_KEY is not set. Ensure that the fish config links are installed with the `sync_configs.fish script."
    exit 1
end

echo "Generating ssh key and copying public key to clipboard..."

function copy_public_key_to_clipboard
    cat "$SSH_KEY.pub" | wl-copy
    echo "Copied public key to clipboard."
end

if test -f $SSH_KEY
    copy_public_key_to_clipboard
    echo "ssh key ($ssh_key) already exists. Exiting."
    exit
end

ssh-keygen -t ed25519 -C "ianhenderson@pm.me"

eval (ssh-agent -c)

ssh-add $SSH_KEY

copy_public_key_to_clipboard
