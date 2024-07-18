#!/usr/bin/env bash

echo -e "\n\nAdd Flathub repository\n"
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo -e "Remove RPM Firefox version\n"
sudo dnf remove --assumeyes firefox-langpacks firefox

declare -a flatpaks=(
    "com.spotify.Client"
    "com.github.tchx84.Flatseal"
    "com.mattjakeman.ExtensionManager"
    "io.dbeaver.DBeaverCommunity"
    "io.github.flattool.Warehouse"
    "io.podman_desktop.PodmanDesktop"
    "me.iepure.devtoolbox"
    "nl.hjdskes.gcolor3"
    "org.mozilla.Thunderbird"
    "org.mozilla.firefox"
    "org.onlyoffice.desktopeditors"
    "org.raspberrypi.rpi-imager"
    "org.videolan.VLC"
    "uk.org.greenend.chiark.sgtatham.putty"
    "org.gtk.Gtk3theme.adw-gtk3-dark"
    "org.gtk.Gtk3theme.Adwaita-dark"
    "org.freedesktop.Platform.VAAPI.Intel"
    "com.github.xournalpp.xournalpp"
)

echo -e "Install Flatpak packages\n"
for pkg in "${flatpaks[@]}"; do
    flatpak install --assumeyes flathub "$pkg"
done

echo -e "Flatpaks installed\n"

echo -e "Override Flatpak user configurations\n"
flatpak override --user --env=ICON_THEME=Papirus
flatpak override --user --filesystem=xdg-config/Kvantum:ro
flatpak override --user --filesystem=~/.themes
flatpak override --user --filesystem=~/.local/share/themes
flatpak override --user --filesystem=xdg-config/gtk-3.0
flatpak override --user --filesystem=~/.local/share/fonts
flatpak override --user --filesystem=~/.local/share/icons
flatpak override --user --filesystem=~/.icons
flatpak override --user --filesystem=xdg-config/gtk-4.0

# Specific for app
flatpak override --user --env=GTK_THEME=adw-gtk3-dark nl.hjdskes.gcolor3
flatpak override --user --env=GTK_THEME=adw-gtk3-dark io.dbeaver.DBeaverCommunity
flatpak override --user --env=GTK_THEME=adw-gtk3-dark org.mozilla.firefox
flatpak override --user --env=GTK_THEME=adw-gtk3-dark uk.org.greenend.chiark.sgtatham.putty
flatpak override --user --env=MOZ_ENABLE_WAYLAND=1 org.mozilla.Thunderbird