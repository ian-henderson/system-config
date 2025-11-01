#!/usr/bin/env fish

sudo flatpak remote-add --if-not-exists \
    flathub https://dl.flathub.org/repo/flathub.flatpakrepo

sudo flatpak install -y \
    ca.desrt.dconf-editor \
    com.brave.Browser \
    com.github.johnfactotum.Foliate \
    com.github.tchx84.Flatseal \
    com.google.AndroidStudio \
    com.jetbrains.IntelliJ-IDEA-Community \
    com.mattjakeman.ExtensionManager \
    de.haeckerfelix.Fragments \
    io.missioncenter.MissionCenter \
    me.timschneeberger.GalaxyBudsClient \
    me.proton.Mail \
    me.proton.Pass \
    org.gimp.GIMP \
    org.gnome.baobab \
    org.gnome.Boxes \
    org.gnome.Snapshot \
    org.libreoffice.LibreOffice \
    org.signal.Signal
