# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

function generate-ssh-key
    set -l key "$HOME/.ssh/id_ed25519"

    if test -e $key
        echo "Key already exists at $key"
        return 1
    end

    ssh-keygen -C "ianhenderson@pm.me" -f $key -t ed25519
    eval (ssh-agent -c)
    ssh-add $key

    if type -q wl-copy
        cat "$key.pub" | wl-copy
        echo "Copied public key to the clipboard"
    end
end
