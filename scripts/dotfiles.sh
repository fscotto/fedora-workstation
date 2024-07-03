#!/usr/bin/env bash

echo -e "\n\nCopying dotfiles from my GitHub repo"

git clone https://github.com/fscotto/dotfiles.git

configs=("bat" "fastfetch" "fish" "nvim" "ranger" "starship.toml")
for f in "${configs[@]}"; do 
    rsync -avxHAWX --delete --fsync "$SCRIPT_DIR/dotfiles/$f" "$HOME/.config"    
done

dotfiles=(".gitignore_global" ".gitconfig")
for f in "${dotfiles[@]}"; do
    rsync -avxHAWX --delete --fsync "$SCRIPT_DIR/dotfiles/$f" "$HOME" 
done

rm -rf "$SCRIPT_DIR/dotfiles"