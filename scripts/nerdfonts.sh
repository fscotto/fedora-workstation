#!/usr/bin/env bash

echo -e "Install Nerd Fonts\n"
git clone https://github.com/ryanoasis/nerd-fonts.git
eval "$SCRIPT_DIR/nerd-fonts/install.sh"