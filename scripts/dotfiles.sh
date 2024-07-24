#!/usr/bin/env bash

DOTFILES_LOC="$HOME"/.dotfiles

echo -e "\n\nInstall GNU Stow for handle dotfiles\n"
sudo dnf install --assumeyes stow

echo -e "Copying dotfiles from my GitHub repo\n"
git clone --recursive https://github.com/fscotto/dotfiles.git "$DOTFILES_LOC"

packages=(
  "bat"
  "fastfetch"
  "fish"
  "git"
  "kitty"
  "nvim"
  "starship"
  "tmux"
  "yazi"
)
for pkg in "${packages[@]}"; do
  stow --dotfiles --dir "$DOTFILES_LOC" "$pkg"
done
