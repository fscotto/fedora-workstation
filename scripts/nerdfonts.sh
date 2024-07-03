#!/usr/bin/env bash

echo -e "\n\nInstall Nerd Fonts\n"
#git clone https://github.com/ryanoasis/nerd-fonts.git
#eval "$SCRIPT_DIR/nerd-fonts/install.sh"

mkdir -p ~/.local/share/fonts

cd /tmp || exit

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/RobotoMono.zip
unzip RobotoMono.zip -d RobotoMono
cp RobotoMono/*.ttf ~/.local/share/fonts
rm -rf RobotoMono.zip RobotoMono

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono
cp JetBrainsMono/*.ttf ~/.local/share/fonts
rm -rf JetBrainsMono.zip JetBrainsMono

fc-cache -f -v
cd - || exit