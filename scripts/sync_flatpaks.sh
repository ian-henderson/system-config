#!/usr/bin/env bash

for repo in fedora fedora-testing; do
	if flatpak remotes | grep -q "$repo"; then
		echo "Removing $repo flatpak repo..."
		flatpak remote-delete --force "$repo"
	else
		echo "$repo flatpak repo doesn't exist."
	fi
done

sudo flatpak remote-add --if-not-exists \
	 flathub https://dl.flathub.org/repo/flathub.flatpakrepo

gnome_packages=(
	ca.desrt.dconf-editor
	com.github.johnfactotum.Foliate
	de.haeckerfelix.Fragments
	io.bassi.Amberol
	io.missioncenter.MissionCenter
	org.gnome.baobab
	org.gnome.Boxes
	org.gnome.Papers
	org.gnome.Snapshot
	com.mattjakeman.ExtensionManager
)

main_packages=(
	com.calibre_ebook.calibre
	com.github.tchx84.Flatseal
	com.protonvpn.www
	io.mgba.mGBA
	me.timschneeberger.GalaxyBudsClient
	me.proton.Pass
	org.freac.freac
	org.gimp.GIMP
	org.kde.kid3
	org.libreoffice.LibreOffice
	org.mozilla.firefox
	org.signal.Signal
	org.telegram.desktop
	org.videolan.VLC
)

echo "Installing Flatpak packages..."
sudo flatpak install -y flathub "${main_packages[@]}"

flatpak override --user --filesystem=~/.fonts
