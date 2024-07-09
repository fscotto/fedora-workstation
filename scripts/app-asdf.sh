#!/usr/bin/env bash

echo -e "Install asdf VM\n"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0

. "$HOME/.asdf/asdf.sh"

function asdf_install
{
    local target="$1"
    local plugin="${2:-target}"

    asdf plugin add "$plugin"
    asdf install "$target" latest
    asdf global "$target" latest
}

echo -e "Install Gitlab CLI client\n"
asdf_install "glab"

echo -e "Install K8S CLI client\n"
asdf_install "kubectl"
