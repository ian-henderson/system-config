#!/usr/bin/env fish

sudo flatpak remote-add --if-not-exists \
    flathub https://dl.flathub.org/repo/flathub.flatpakrepo

sudo flatpak install -y \
    ca.desrt.dconf-editor \
    com.brave.Browser \
    com.calibre_ebook.calibre \
    com.github.johnfactotum.Foliate \
    com.github.tchx84.Flatseal \
    com.mattjakeman.ExtensionManager \
    com.protonvpn.www \
    de.haeckerfelix.Fragments \
    io.bassi.Amberol \
    io.missioncenter.MissionCenter \
    me.timschneeberger.GalaxyBudsClient \
    me.proton.Pass \
    org.freac.freac \
    org.gimp.GIMP \
    org.gnome.baobab \
    org.gnome.Boxes \
    org.gnome.Papers \
    org.gnome.Snapshot \
    org.kde.kid3 \
    org.libreoffice.LibreOffice \
    org.mozilla.firefox \
    org.signal.Signal \
    org.telegram.desktop

flatpak override --user --filesystem=~/.fonts
