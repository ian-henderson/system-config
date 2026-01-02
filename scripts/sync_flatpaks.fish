#!/usr/bin/env fish

sudo flatpak remote-add --if-not-exists \
    flathub https://dl.flathub.org/repo/flathub.flatpakrepo

set -l gnome_packages \
    ca.desrt.dconf-editor \
    de.haeckerfelix.Fragments \
    io.bassi.Amberol \
    io.missioncenter.MissionCenter \
    org.gnome.baobab \
    org.gnome.Boxes \
    org.gnome.Papers \
    org.gnome.Snapshot \
    com.mattjakeman.ExtensionManager \

sudo flatpak install -y \
    com.brave.Browser \
    com.calibre_ebook.calibre \
    com.github.johnfactotum.Foliate \
    com.github.tchx84.Flatseal \
    com.protonvpn.www \
    me.timschneeberger.GalaxyBudsClient \
    me.proton.Pass \
    org.freac.freac \
    org.gimp.GIMP \
    org.kde.kid3 \
    org.libreoffice.LibreOffice \
    org.signal.Signal \
    org.telegram.desktop

flatpak override --user --filesystem=~/.fonts
