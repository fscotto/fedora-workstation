#!/usr/bin/env bash

declare -a PACKAGES=(
  "btop"
  "dconf-editor"
  "elixir"
  "erlang"
  "exercism"
  "ffmpegthumbnailer"
  "filezilla"
  "firewall-config"
  "htop"
  "httpie"
  "hugo"
  "hwinfo"
  "kitty"
  "inotify-tools"
  "jq"
  "luarocks"
  "neovim"
  "meld"
  "pipx"
  "python3-virtualenv"
  "qemu"
  "ripgrep"
  "rsync"
  "sushi"
  "telegram-desktop"
  "tmux"
  "unar"
  "xclip"
  "zoxide"
)

echo -e "Remove unused RPM apps\n"
sudo dnf remove --assumeyes gnome-connections rhythmbox totem gnome-terminal

echo -e "\n\nInstall RPM packages\n"
sudo dnf install --assumeyes "${PACKAGES[@]}"
