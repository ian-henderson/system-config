#!/usr/bin/env fish

sudo pacman -S --needed --noconfirm fish

# fisher
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# https://github.com/jorgebucaran/nvm.fish
fisher install jorgebucaran/nvm.fish
