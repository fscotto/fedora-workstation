#!/usr/bin/env bash

status=$(package_status "starship")
if [ "$status" -ne 0 ]; then
  echo -e "\n\nInstall Starship from Copr repo\n"
  sudo dnf copr enable --assumeyes atim/starship
  sudo dnf install --assumeyes starship
else
  echo -e "\nStarship already installed!\n"
fi

