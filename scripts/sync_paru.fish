#!/usr/bin/env fish

if ! test -q paru
	echo "Paru is not installed. Run the `install_paru.fish` script first."
	exit 1
end

# maybe install vscode via flatpak instead?
set -l packages \
	miniconda3 \
	visual-studio-code

paru -S $packages --noconfirm
