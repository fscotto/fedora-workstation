#!/usr/bin/env bash

declare -a PACKAGES=(
    "btop"
    "dconf-editor"
    "elixir"
    "erlang"
    "filezilla"
    "firewall-config"
    "htop"
    "httpie"
    "hugo"
    "hwinfo"
    "jq"
    "neovim"
    "meld"
    "pipx"
    "python3-virtualenv"
    "qemu"
    "ranger"
    "rsync"
    "rustup"
    "sushi"
    "xclip"
)

echo -e "Install RPM packages\n"
sudo dnf install --assumeyes "${PACKAGES[@]}"