#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# -------------------------------------------------------
# Docker Installer Script for Fedora
#
# Installs Docker CE if not already installed,
# adds the Docker repository, enables the service,
# and configures the user for non-root Docker usage.
# -------------------------------------------------------

# Load shared libraries
source "$(dirname "${BASH_SOURCE[0]}")/../lib/logging.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../lib/functions.sh"

# Check if Docker is already installed
if package_status "docker-ce"; then
    log_info "Docker is already installed. Skipping installation."
    return 0
fi

log_info "Installing Docker CE and related packages..."

# Install necessary plugin for DNF and add Docker repo
sudo dnf install --assumeyes dnf-plugins-core
log_debug "Installed dnf-plugins-core"

sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
log_debug "Docker CE repository added"

# Install Docker CE and components
sudo dnf install --assumeyes docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
log_info "Docker CE installed successfully"

# Add current user to 'docker' group
log_info "Adding user '${USER}' to the docker group"
sudo usermod -aG docker "${USER}"

log_warn "You must log out and log back in for group membership changes to take effect."

# Enable and start Docker service
log_info "Enabling and starting the Docker systemd service"
sudo systemctl enable --now docker.service

log_info "Docker setup complete."

