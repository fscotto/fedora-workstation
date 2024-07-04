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
    "sushi"
    "xclip"
)

echo -e "\n\nInstall RPM packages\n"
sudo dnf install --assumeyes "${PACKAGES[@]}"