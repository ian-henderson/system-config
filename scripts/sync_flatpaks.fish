#!/usr/bin/env fish

sudo flatpak remote-add --if-not-exists \
    flathub https://dl.flathub.org/repo/flathub.flatpakrepo

sudo flatpak install -y \
    app.devsuite.Ptyxis \
    ca.desrt.dconf-editor \
    ch.protonmail.protonmail-bridge \
    com.discordapp.Discord \
    com.github.johnfactotum.Foliate \
    com.github.tchx84.Flatseal \
    com.mattjakeman.ExtensionManager \
    com.protonvpn.www \
    de.haeckerfelix.Fragments \
    de.haeckerfelix.Shortwave \
    io.missioncenter.MissionCenter \
    me.timschneeberger.GalaxyBudsClient \
    org.gimp.GIMP \
    org.gnome.baobab \
    org.gnome.Boxes \
    org.gnome.Papers \
    org.gnome.Snapshot \
    org.signal.Signal \
    us.zoom.Zoom
