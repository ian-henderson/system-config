#!/bin/bash

flatpak remote-add --if-not-exists \
	flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install -y \
	app.devsuite.Ptyxis \
	ca.desrt.dconf-editor \
	ch.protonmail.protonmail-bridge \
	com.calibre_ebook.calibre \
	com.discordapp.Discord \
	com.github.johnfactotum.Foliate \
	com.github.tchx84.Flatseal \
	com.mattjakeman.ExtensionManager \
	com.protonvpn.www \
	de.haeckerfelix.Shortwave \
	io.missioncenter.MissionCenter \
	me.timschneeberger.GalaxyBudsClient \
	org.gimp.GIMP \
	org.gnome.Papers \
	org.gnome.baobab \
	org.mozilla.Thunderbird \
	org.signal.Signal \
	us.zoom.Zoom
