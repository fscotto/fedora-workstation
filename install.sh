#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# Export current path of installer script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export SCRIPT_DIR

# Create folder for external binaries
mkdir -p ~/.local/bin/

# Needed for all installers
echo -e "Upgrade Fedora installation\n"
sudo dnf upgrade --assumeyes
sudo dnf install --assumeyes curl git unzip

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

echo -e "Apply all setting reboot your computer"
sudo systemctl reboot 