#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# -------------------------------------------------------
# Flatpak Setup Script
#
# Adds Flathub repository,
# removes RPM Firefox if installed,
# installs a curated list of Flatpak apps from various remotes,
# and applies user-specific Flatpak overrides.
# -------------------------------------------------------

# Load shared libraries
source "$(dirname "${BASH_SOURCE[0]}")/../lib/logging.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../lib/functions.sh"

log_info "Adding Flathub repository if not already present..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-modify --enable flathub

if package_status "firefox"; then
    log_info "Removing RPM Firefox and language packs to avoid conflicts with Flatpak version..."
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
  ["ca.desrt.dconf-editor"]="flathub"
  ["io.github.Qalculate"]="flathub"
  ["io.github.troyeguo.koodo-reader"]="flathub"
  ["org.filezillaproject.Filezilla"]="flathub"
  ["org.fedoraproject.FirewallConfig"]="fedora"
  ["org.gnome.seahorse.Application"]="flathub"
  ["org.telegram.desktop"]="flathub"
  ["io.github.pwr_solaar.solaar"]="flathub"
  ["org.gnome.Boxes"]="flathub"
  ["net.codeindustry.MasterPDFEditor"]="flathub"
)

log_info "Installing Flatpak packages..."
for pkg in "${!FLATPAKS[@]}"; do
  remote="${FLATPAKS[$pkg]}"
  log_debug "Installing $pkg from remote $remote"
  flatpak install --assumeyes "$remote" "$pkg"
done
log_info "Flatpak packages installed successfully."

log_info "Applying Flatpak user overrides..."
flatpak override --user --env=ICON_THEME=Papirus
flatpak override --user --filesystem=xdg-config/Kvantum:ro
flatpak override --user --filesystem=~/.themes
flatpak override --user --filesystem=~/.local/share/themes
flatpak override --user --filesystem=xdg-config/gtk-3.0
flatpak override --user --filesystem=~/.local/share/fonts
flatpak override --user --filesystem=~/.local/share/icons
flatpak override --user --filesystem=~/.icons
flatpak override --user --filesystem=xdg-config/gtk-4.0

# Theme and environment overrides specific for some apps
flatpak override --user --env=GTK_THEME=adw-gtk3-dark nl.hjdskes.gcolor3
flatpak override --user --env=GTK_THEME=adw-gtk3-dark io.dbeaver.DBeaverCommunity
flatpak override --user --env=GTK_THEME=adw-gtk3-dark org.mozilla.firefox
flatpak override --user --env=GTK_THEME=adw-gtk3-dark uk.org.greenend.chiark.sgtatham.putty
flatpak override --user --env=MOZ_ENABLE_WAYLAND=1 org.mozilla.Thunderbird
flatpak override --user --env=GTK_THEME=Adwaita-dark org.freefilesync.FreeFileSync
flatpak override --user --env=GTK_THEME=adw-gtk3-dark com.github.xournalpp.xournalpp
flatpak override --user --env=GTK_THEME=Adwaita-dark org.fedoraproject.FirewallConfig
flatpak override --user --env=GTK_THEME=Adwaita-dark io.github.Qalculate
flatpak override --user --env=GTK_THEME=adw-gtk3-dark io.github.pwr_solaar.solaar

log_info "Flatpak configuration completed."

