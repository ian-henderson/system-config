#!/usr/bin/env fish

if ! test -q paru
    echo "Paru is not installed. Run the `install_paru.fish` script first."
    exit 1
end

set -l packages \
    clang-format-static-bin \
    miniconda3 \
    visual-studio-code-bin

paru -S $packages --noconfirm
