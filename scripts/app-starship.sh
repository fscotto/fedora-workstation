#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# -------------------------------------------------------
# Starship Prompt Installer Script for Fedora
#
# Enables the COPR repository and installs
# the Starship prompt if not already installed.
# -------------------------------------------------------

# Load shared libraries
source "$(dirname "${BASH_SOURCE[0]}")/../lib/logging.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../lib/functions.sh"

# Check if Starship is already installed
if package_status "starship"; then
    log_info "Starship is already installed. Skipping installation."
    return 0
fi

log_info "Installing Starship prompt from COPR repository..."

# Enable COPR repo and install Starship
sudo dnf copr enable --assumeyes atim/starship
sudo dnf install --assumeyes starship

log_info "Starship installation completed successfully."

