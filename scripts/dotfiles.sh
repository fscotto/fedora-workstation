#!/usr/bin/env bash

DOTFILES_LOC="$HOME"/.dotfiles
CONFIG_DIR="$HOME/.config"

status=$(package_status "stow")
if [ "$status" -ne 0 ]; then
  echo -e "\n\nInstall GNU Stow for handle dotfiles"
  sudo dnf install --assumeyes stow
else
  echo -e "\nGNU Stow already installed"
fi

if [ ! -d "$DOTFILES_LOC" ]; then
  echo -e "Copying dotfiles from my GitHub repo"
  git clone --recursive https://github.com/fscotto/dotfiles.git "$DOTFILES_LOC"
else
  echo -e "Directory in $DOTFILES_LOC already exists"
fi

packages=(
  "bat"
  "btop"
  "fastfetch"
  "fish"
  "git"
  "k9s"
  "kitty"
  "lazydocker"
  "lazygit"
  "nvim"
  "ov"
  "starship"
  "tmux"
  "yazi"
)
for pkg in "${packages[@]}"; do
  absolute_pkg_path="${CONFIG_DIR}/$pkg"
  if [ -d "$absolute_pkg_path" ] && [ ! -L "$absolute_pkg_path" ]; then
    echo -e "The directory $absolute_pkg_path will removed"
    rm -rf "$absolute_pkg_path"
  fi

  stow --dotfiles --dir "$DOTFILES_LOC" -R "$pkg"
done

echo -e "Clone Git prompt for Bash Shell\n"
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
