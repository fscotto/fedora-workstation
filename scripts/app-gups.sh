#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# -------------------------------------------------------
# GUPS (Greencell) Installer Script for Fedora
#
# Adds the Greencell RPM repository and installs
# the 'gcups' package if it is not already installed.
# -------------------------------------------------------

# Load shared libraries
source "$(dirname "${BASH_SOURCE[0]}")/../lib/logging.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../lib/functions.sh"

# Check if gcups is already installed
if package_status "gcups"; then
    log_info "GUPS is already installed. Skipping installation."
    return 0
fi

log_info "Installing GUPS (Greencell software)..."

# Import GPG key and add repository
sudo rpm --import https://gcups-static.greencell.global/csgsa-keyring.gpg
log_debug "Imported GUPS GPG key"

sudo dnf config-manager --add-repo https://gcups-static.greencell.global/rpm/gcups.repo
log_debug "Added GUPS repository"

# Install the gcups package
sudo dnf install --assumeyes gcups
log_info "GUPS installed successfully."

