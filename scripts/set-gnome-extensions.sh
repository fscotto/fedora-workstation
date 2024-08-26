#!/usr/bin/env bash

USER_EXT=~/.local/share/gnome-shell/extensions
SYSTEM_EXT=/usr/share/glib-2.0/schemas/

echo -e "\n\nInstall GNOME Extension CLI tool\n"
pipx install gnome-extensions-cli --system-site-packages

echo -e "Install GNOME Extensions\n"
extensions=(
  "clipboard-history@alexsaveau.dev"
  "drive-menu@gnome-shell-extensions.gcampax.github.com"
  "gnome-ui-tune@itstime.tech"
  "caffeine@patapon.info"
  "bluetooth-quick-connect@bjarosze.gmail.com"
  "user-theme@gnome-shell-extensions.gcampax.github.com"
  "no-overview@fthx"
  "status-area-horizontal-spacing@mathematical.coffee.gmail.com"
  "appindicatorsupport@rgcjonas.gmail.com"
)
for ext in "${extensions[@]}"; do
  gext install "$ext"
done

sudo cp "${USER_EXT}"/bluetooth-quick-connect@bjarosze.gmail.com/schemas/org.gnome.shell.extensions.bluetooth-quick-connect.gschema.xml "${SYSTEM_EXT}"
sudo cp "${USER_EXT}"/caffeine@patapon.info/schemas/org.gnome.shell.extensions.caffeine.gschema.xml "${SYSTEM_EXT}"
sudo cp "${USER_EXT}"/clipboard-history@alexsaveau.dev/schemas/org.gnome.shell.extensions.clipboard-indicator.gschema.xml "${SYSTEM_EXT}"
sudo cp "${USER_EXT}"/gnome-ui-tune@itstime.tech/schemas/org.gnome.shell.extensions.gnome-ui-tune.gschema.xml "${SYSTEM_EXT}"
sudo cp "${USER_EXT}"/user-theme@gnome-shell-extensions.gcampax.github.com/schemas/org.gnome.shell.extensions.user-theme.gschema.xml "${SYSTEM_EXT}"
sudo cp "${USER_EXT}"/status-area-horizontal-spacing@mathematical.coffee.gmail.com/schemas/org.gnome.shell.extensions.status-area-horizontal-spacing.gschema.xml "${SYSTEM_EXT}"
sudo glib-compile-schemas "${SYSTEM_EXT}"

echo -e "Configure GNOME Extensions\n"

# Background Logo
gsettings set org.fedorahosted.background-logo-extension logo-always-visible true

# Caffeine
gsettings set org.gnome.shell.extensions.caffeine inhibit-apps "['org.videolan.VLC.desktop']"

# Bluetooth Quick Connect
gsettings set org.gnome.shell.extensions.bluetooth-quick-connect show-battery-value-on true

# Status Area Horizontal Spacing
gsettings set org.gnome.shell.extensions.status-area-horizontal-spacing hpadding 5
