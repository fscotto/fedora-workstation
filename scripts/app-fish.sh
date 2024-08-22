#!/usr/bin/env bash

status=$(package_status "fish")
if [ "$status" -ne 0 ]; then
  echo -e "\n\nInstall packages for fish shell configuration\n"
  sudo dnf install --assumeyes bat duf eza fastfetch fastfetch-fish-completion fd-find fish fzf ugrep

  chsh -s /bin/fish

  echo -e "Configure venv for Fish shell"
  pipx install virtualfish
  vf install
else
  echo -e "\nFish configuration already installed!\n"
fi
