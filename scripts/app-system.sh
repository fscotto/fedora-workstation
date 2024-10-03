#!/usr/bin/env bash

declare -a PACKAGES=(
  "btop"
  "clang"
  "clang-tools-extra"
  "cmatrix"
  "dwarves"
  "exercism"
  "git-delta"
  "git-extras"
  "htop"
  "httpie"
  "hwinfo"
  "hexyl"
  "inotify-tools"
  "jq"
  "kitty"
  "libasan"
  "libasan-static"
  "luarocks"
  "nautilus-extensions"
  "nautilus-python"
  "neovim"
  "miller"
  "minicom"
  "ov"
  "perl-Image-ExifTool"
  "pipx"
  "python3-virtualenv"
  "qemu"
  "ripgrep"
  "rsync"
  "sushi"
  "tmux"
  "unar"
  "xclip"
  "zoxide"
)

status=$(package_status "gnome-connections")
if [ "$status" -eq 0 ]; then
  echo -e "Remove unused RPM apps\n"
  sudo dnf remove --assumeyes gnome-connections rhythmbox totem gnome-terminal
fi

status=$(package_status "btop")
if [ "$status" -ne 0 ]; then
  echo -e "\n\nInstall RPM packages\n"
  sudo dnf install --assumeyes "${PACKAGES[@]}"
fi

status=$(package_status "bat-extras")
if [ "$status" -ne 0 ]; then
  sudo dnf copr enable --assumeyes awood/bat-extras
  sudo dnf install --assumeyes bat-extras
fi

# Set kitty as default system terminal emulator
[ -e /usr/local/bin/gnome-terminal ] && sudo rm /usr/local/bin/gnome-terminal
sudo ln -s /usr/bin/kitty /usr/local/bin/gnome-terminal
