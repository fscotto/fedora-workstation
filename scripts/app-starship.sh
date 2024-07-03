#!/usr/bin/env bash

echo -e "\n\nInstall Starship from Copr repo\n"
sudo dnf copr enable --assumeyes atim/starship
sudo dnf install --assumeyes starship