#!/usr/bin/env bash

if [ ! -d /home/linuxbrew/.linuxbrew ]; then
  echo -e "\n\nInstall Homebrew on Linux"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo -e "\nHomebrew already installed"
fi

echo -e "Install Homebrew packages"
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install kubernetes-cli openshift-cli argocd helm kind glab yazi
brew install lazygit lazydocker exiftool glow viu moar
brew install erlang_ls
echo -e "Homebrew packages installed"
