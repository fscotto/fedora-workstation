#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# -------------------------------------------------------
# Postman Installer Script for Fedora
#
# Enables the Postman COPR repository and installs
# Postman along with OpenSSL if not already installed.
# -------------------------------------------------------

# Load shared libraries
source "$(dirname "${BASH_SOURCE[0]}")/../lib/logging.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../lib/functions.sh"

# Check if Postman is already installed
if package_status "postman"; then
    log_info "Postman is already installed. Skipping installation."
    return 0
fi

log_info "Installing Postman from COPR repository..."

# Enable COPR repo and install packages
sudo dnf copr enable --assumeyes coder966/postman
sudo dnf install --assumeyes openssl postman

log_info "Postman installation completed successfully."

