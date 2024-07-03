#!/usr/bin/env bash

echo -e "\n\nInstall packages for fish shell configuration\n"
sudo dnf install --assumeyes bat duf eza fastfetch fastfetch-fish-completion fd-find fish fzf ugrep

chsh -s /bin/fish