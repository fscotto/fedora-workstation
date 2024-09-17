#!/usr/bin/env bash

echo -e "\n\nAdd Flathub repository\n"
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-modify --enable flathub

status=$(package_status "firefox")
if [ "$status" -eq 0 ]; then
  echo -e "Remove RPM Firefox version\n"
  sudo dnf remove --assumeyes firefox-langpacks firefox
fi

declare -A FLATPAKS=(
  ["com.spotify.Client"]="flathub"
  ["com.github.tchx84.Flatseal"]="flathub"
  ["com.mattjakeman.ExtensionManager"]="flathub"
  ["io.dbeaver.DBeaverCommunity"]="flathub"
  ["io.github.flattool.Warehouse"]="flathub"
  ["me.iepure.devtoolbox"]="flathub"
  ["nl.hjdskes.gcolor3"]="flathub"
  ["org.mozilla.Thunderbird"]="flathub"
  ["org.mozilla.firefox"]="flathub"
  ["org.onlyoffice.desktopeditors"]="flathub"
  ["org.raspberrypi.rpi-imager"]="flathub"
  ["org.videolan.VLC"]="flathub"
  ["uk.org.greenend.chiark.sgtatham.putty"]="flathub"
  ["org.gtk.Gtk3theme.adw-gtk3-dark"]="flathub"
  ["org.gtk.Gtk3theme.Adwaita-dark"]="flathub"
  ["org.freedesktop.Platform.VAAPI.Intel/x86_64/23.08"]="flathub"
  ["com.github.xournalpp.xournalpp"]="flathub"
  ["com.usebruno.Bruno"]="flathub"
  ["org.freefilesync.FreeFileSync"]="flathub"
)

echo -e "Install Flatpak packages\n"
for pkg in "${!FLATPAKS[@]}"; do
  remote="${FLATPAKS[${pkg}]}"
  flatpak install --assumeyes "$remote" "$pkg"
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
flatpak override --user --env=GTK_THEME=Adwaita-dark org.freefilesync.FreeFileSync
flatpak override --user --env=GTK_THEME=adw-gtk3-dark com.github.xournalpp.xournalpp
