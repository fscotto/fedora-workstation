#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# -------------------------------------------------------
# Haskell & GHCup Installer Script for Fedora
#
# Installs development dependencies and then downloads
# and runs the official GHCup installer for Haskell.
# -------------------------------------------------------

# Load shared libraries
source "$(dirname "${BASH_SOURCE[0]}")/../lib/logging.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../lib/functions.sh"

log_info "Installing development dependencies required by GHCup..."

# Install required development packages
sudo dnf install --assumeyes \
    gcc \
    gcc-c++ \
    gmp \
    gmp-devel \
    make \
    ncurses \
    ncurses-compat-libs \
    xz \
    perl

log_info "Dependencies installed."

# Run the official GHCup installer
log_info "Downloading and executing the GHCup installer..."
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

log_info "GHCup installation completed. Please follow any instructions shown by the installer."

