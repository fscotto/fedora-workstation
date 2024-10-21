#!/usr/bin/env bash

status=$(package_status "pycharm-community")
if [ "$status" -ne 0 ]; then
  echo -e "\n\nInstall PyCharm Community Edition from Copr repo\n"
  sudo dnf copr enable --assumeyes phracek/PyCharm
  sudo dnf install --assumeyes pycharm-community
else
  echo -e "\nPyCharm Community Edition already installed\n"
fi
