#!/usr/bin/env bash

status=$(package_status "gups")
if [ "$status" -ne 0 ]; then
  echo -e "Install Greencell program\n"
  sudo rpm --import https://gcups-static.greencell.global/csgsa-keyring.gpg
  sudo dnf config-manager --add-repo https://gcups-static.greencell.global/rpm/gcups.repo
  sudo dnf install gcups -y
else
  echo -e "Gups already installed\n"
fi
