#!/usr/bin/env bash

echo -e "\n\nInstall GNOME Extension CLI tool\n"
pipx install gnome-extensions-cli --system-site-packages

echo -e "Install GNOME Extensions\n"
extensions=(
    "clipboard-history@alexsaveau.dev"
    "drive-menu@gnome-shell-extensions.gcampax.github.com"
    "gnome-ui-tune@itstime.tech"
    "caffeine@patapon.info"
    "bluetooth-quick-connect@bjarosze.gmail.com"
    "no-overview@fthx"
)
for ext in "${extensions[@]}"; do
    gext install "$ext"
done
