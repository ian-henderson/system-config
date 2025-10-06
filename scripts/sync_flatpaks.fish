#!/usr/bin/env fish

sudo flatpak remote-add --if-not-exists \
    flathub https://dl.flathub.org/repo/flathub.flatpakrepo

sudo flatpak install -y \
    ca.desrt.dconf-editor \
    ch.protonmail.protonmail-bridge \
    com.brave.Browser \
    com.github.johnfactotum.Foliate \
    com.github.tchx84.Flatseal \
    com.jetbrains.IntelliJ-IDEA-Community \
    com.mattjakeman.ExtensionManager \
    com.plexamp.Plexamp \
    com.protonvpn.www \
    com.slack.Slack \
    de.haeckerfelix.Fragments \
    de.haeckerfelix.Shortwave \
    io.missioncenter.MissionCenter \
    me.timschneeberger.GalaxyBudsClient \
    me.proton.Mail \
    me.proton.Pass \
    org.gimp.GIMP \
    org.gnome.baobab \
    org.gnome.Boxes \
    org.gnome.Papers \
    org.gnome.Snapshot \
    org.mozilla.Thunderbird \
    org.signal.Signal \
    us.zoom.Zoom
