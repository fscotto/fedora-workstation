#!/usr/bin/env bash

status=$(package_status "zellij")
if [ "$status" -ne 0 ]; then
  echo -e "\n\nInstall Zellij from Copr repo\n"
  sudo dnf copr enable --assumeyes varlad/zellij
  sudo dnf install --assumeyes zellij
else
  echo -e "\nZellij already installed\n"
fi

