#!/usr/bin/env bash

echo -e "Install asdf VM\n"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0

. "$HOME/.asdf/asdf.sh"

echo -e "Install Gitlab CLI client\n"
asdf plugin add glab
asdf install glab latest
asdf global glab latest
