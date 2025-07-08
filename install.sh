#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

# -------------------------------------------------------
# Fedora Workstation Installer Script
#
# This script prepares a Fedora environment for
# development and software compilation.
# It performs system upgrades, installs essential tools,
# and runs modular installer scripts.
# -------------------------------------------------------

# Resolve and export the path to this script
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
export SCRIPT_DIR

# Source required libraries
source "$SCRIPT_DIR/lib/logging.sh"
source "$SCRIPT_DIR/lib/functions.sh"

# Detect Fedora version
FEDORA_VER=$(fedora_version)
export FEDORA_VER

log_info "Starting software setup for Fedora $FEDORA_VER"

# Create directory for user-installed binaries
mkdir -p ~/.local/bin/
log_debug "Ensured existence of ~/.local/bin"

# Update system and install required base packages
log_info "Upgrading Fedora system packages..."
sudo dnf upgrade --assumeyes --best --allowerasing

log_info "Installing essential developer tools: curl, git, unzip, dnf-utils, pipx"
sudo dnf install --assumeyes curl git unzip dnf-utils pipx

# Temporarily disable screen locking and idle timeout
log_info "Disabling screen lock and idle timeout during installation"
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 0

# Run all modular installer scripts from the 'scripts' directory
log_info "Running installer scripts from: $SCRIPT_DIR/scripts"
for script in "$SCRIPT_DIR"/scripts/*.sh; do
    log_debug "Executing: $script"
    source "$script"
done

# Re-enable screen locking and idle timeout
log_info "Restoring screen lock and idle timeout settings"
gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.session idle-delay 300

# Cleanup: remove script directory
log_info "Cleaning up installation directory"
cd "$HOME"
rm -rf "$SCRIPT_DIR"

log_info "Installation completed successfully. Please reboot your system."

