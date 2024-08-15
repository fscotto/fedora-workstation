#!/usr/bin/env bash

status=$(package_status "intellij-idea-ultimate")
if [ "$status" -ne 0 ]; then
  echo -e "\n\nInstall Intellij Ultimate Edition from Copr repo\n"
  sudo dnf copr enable --assumeyes coder966/intellij-idea-ultimate
  sudo dnf install --assumeyes intellij-idea-ultimate
else
  echo -e "\nIntellij Ultimate Edition already installed\n"
fi
