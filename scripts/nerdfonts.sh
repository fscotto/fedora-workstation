#!/usr/bin/env bash

echo -e "\n\nInstall Nerd Fonts\n"
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

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip
unzip FiraCode.zip -d FiraCode
cp FiraCode/*.ttf ~/.local/share/fonts
rm -rf FiraCode.zip FiraCode

fc-cache -f -v
cd - || exit

