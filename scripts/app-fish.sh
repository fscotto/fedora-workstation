#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# -------------------------------------------------------
# Fish Shell Installer Script for Fedora
#
# Installs Fish shell and common CLI tools,
# and sets Fish as the default shell if not already installed.
# -------------------------------------------------------

# Load shared libraries
source "$(dirname "${BASH_SOURCE[0]}")/../lib/logging.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../lib/functions.sh"

# Check if Fish is already installed
if package_status "fish"; then
    log_info "Fish shell is already installed. Skipping installation."
    return 0
fi

log_info "Installing Fish shell and useful command-line utilities..."

# Install Fish and additional helpful tools
sudo dnf install --assumeyes \
    bat \
    duf \
    eza \
    fastfetch \
    fastfetch-fish-completion \
    fd-find \
    fish \
    fzf \
    ugrep

log_info "Installed Fish shell and utilities."

# Change default shell to Fish
log_info "Setting Fish as the default shell for user '${USER}'"
chsh -s /bin/fish

log_warn "You must log out and log back in for the new shell to take effect."

log_info "Fish shell setup complete."

