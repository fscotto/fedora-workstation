#!/usr/bin/env bash

declare -a PACKAGES=(
    "alacritty"
    "btop"
    "dconf-editor"
    "elixir"
    "erlang"
    "exercism"
    "filezilla"
    "firewall-config"
    "htop"
    "httpie"
    "hugo"
    "hwinfo"
    "inotify-tools"
    "jq"
    "neovim"
    "meld"
    "pipx"
    "python3-virtualenv"
    "qemu"
    "ranger"
    "rsync"
    "sushi"
    "telegram-desktop"
    "tmux"
    "xclip"
)

echo -e "Remove unused RPM apps\n"
sudo dnf remove --assumeyes gnome-connections rhythmbox totem gnome-terminal

echo -e "\n\nInstall RPM packages\n"
sudo dnf install --assumeyes "${PACKAGES[@]}"