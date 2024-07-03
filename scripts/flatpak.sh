#!/usr/bin/env bash

echo -e "Add Flathub repository\n"
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo -e "Remove RPM Firefox\n"
sudo dnf remove --assumeyes firefox-langpacks firefox

echo -e "Install Flatpak packages\n"
while read -r pkg; do
    flatpak install --assumeyes flathub "$pkg"
done < "$SCRIPT_DIR/data/flatpak.txt"

echo -e "Flatpaks installed\n"