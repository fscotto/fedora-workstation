#!/usr/bin/env bash

FONT_DIR=/usr/share/fonts/nerd-fonts

function check_installed_font() {
  local font_name="${1}"
  local entries_num
  entries_num="$(find "${FONT_DIR}" -iname "${font_name}*" | wc -l)"
  ((entries_num > 0)) && echo "Y" || echo "N"
}

echo -e "\n\nInstall Nerd Fonts\n"
sudo mkdir -p "${FONT_DIR}"

cd /tmp || exit

if [ "$(check_installed_font "RobotoMono")" = "N" ]; then
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/RobotoMono.zip
  unzip RobotoMono.zip -d RobotoMono
  sudo mv RobotoMono "${FONT_DIR}"
  rm -rf RobotoMono.zip
fi

if [ "$(check_installed_font "JetBrainsMono")" = "N" ]; then
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
  unzip JetBrainsMono.zip -d JetBrainsMono
  sudo mv JetBrainsMono "${FONT_DIR}"
  rm -rf JetBrainsMono.zip
fi

if [ "$(check_installed_font "FiraCode")" = "N" ]; then
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip
  unzip FiraCode.zip -d FiraCode
  sudo mv FiraCode "${FONT_DIR}"
  rm -rf FiraCode.zip
fi

sudo fc-cache -fv
cd - || exit
