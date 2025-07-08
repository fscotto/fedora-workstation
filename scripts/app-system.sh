#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# -------------------------------------------------------
# System Utilities Installer Script for Fedora
#
# Installs a curated list of RPM packages,
# removes some unused default apps if present,
# enables COPR repo for bat-extras,
# and sets kitty as the default terminal emulator.
# -------------------------------------------------------

# Load shared libraries
source "$(dirname "${BASH_SOURCE[0]}")/../lib/logging.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../lib/functions.sh"

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

# Remove unused default RPM apps if installed
if package_status "gnome-connections"; then
    log_info "Removing unused RPM applications: gnome-connections, rhythmbox, totem, gnome-terminal"
    sudo dnf remove --assumeyes gnome-connections rhythmbox totem gnome-terminal
fi

# Install main RPM packages if not already installed
if ! package_status "btop"; then
    log_info "Installing system utility packages..."
    sudo dnf install --assumeyes "${PACKAGES[@]}"
else
    log_info "System utility packages already installed. Skipping."
fi

# Enable COPR repo and install bat-extras if needed
if ! package_status "bat-extras"; then
    log_info "Enabling COPR repository for bat-extras and installing it..."
    sudo dnf copr enable --assumeyes awood/bat-extras
    sudo dnf install --assumeyes bat-extras
else
    log_info "bat-extras already installed. Skipping."
fi

# Set kitty as the default system terminal emulator
if [ -e /usr/local/bin/gnome-terminal ]; then
    log_info "Removing existing /usr/local/bin/gnome-terminal symlink or binary"
    sudo rm /usr/local/bin/gnome-terminal
fi

log_info "Setting kitty as the default terminal emulator (/usr/local/bin/gnome-terminal -> /usr/bin/kitty)"
sudo ln -s /usr/bin/kitty /usr/local/bin/gnome-terminal

