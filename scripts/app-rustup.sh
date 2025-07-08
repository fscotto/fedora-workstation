#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# -------------------------------------------------------
# Rustup Installer Script for Fedora
#
# Installs rustup and configures the Rust environment,
# including adding the nightly toolchain.
# -------------------------------------------------------

# Load shared libraries
source "$(dirname "${BASH_SOURCE[0]}")/../lib/logging.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../lib/functions.sh"

# Check if rustup is already installed
if package_status "rustup"; then
    log_info "Rustup is already installed. Skipping installation."
    return 0
fi

log_info "Installing rustup..."

# Install rustup package
sudo dnf install --assumeyes rustup

log_info "Running rustup-init..."
rustup-init

# Source cargo environment to current shell
if [[ -f "$HOME/.cargo/env" ]]; then
    log_info "Sourcing cargo environment..."
    # shellcheck disable=SC1090
    source "$HOME/.cargo/env"
else
    log_warn "Cargo environment file not found: $HOME/.cargo/env"
fi

# Add nightly toolchain
log_info "Adding Rust nightly toolchain..."
rustup toolchain add nightly

log_info "Rustup installation and configuration complete."

