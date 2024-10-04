#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

source functions.sh

# Export current path of installer script
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
export SCRIPT_DIR

FEDORA_VER=$(fedora_version)
export FEDORA_VER

echo -e "Installing software compilation on Fedora $FEDORA_VER\n"

# Create folder for external binaries
mkdir -p ~/.local/bin/

# Needed for all installers
echo -e "Upgrade Fedora installation\n"
sudo dnf upgrade --assumeyes --best --allowerasing
sudo dnf install --assumeyes curl git unzip dnf-utils pipx

# Ensure computer doesn't go to sleep or lock while installing
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 0

# Run installers
for script in "$SCRIPT_DIR"/scripts/*.sh; do
  source "$script"
done

# Revert to normal idle and lock settings
gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.session idle-delay 300

cd "$HOME"
rm -rf "$SCRIPT_DIR"

echo -e "Installation finish with successful, reboot your computer"
