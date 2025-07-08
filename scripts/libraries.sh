#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# -------------------------------------------------------
# C Development Libraries Installer
#
# Installs the Fedora group "C Development Tools and Libraries"
# which includes compiler and essential libraries for C development.
# -------------------------------------------------------

source "$(dirname "${BASH_SOURCE[0]}")/../lib/logging.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../lib/functions.sh"

log_info "Installing libraries for C development..."
sudo dnf group install --assumeyes 'C Development Tools and Libraries'

log_info "C development libraries installation completed."

