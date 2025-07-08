#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# -------------------------------------------------------
# RPM Fusion Repositories and Multimedia Codecs Installer
#
# Adds the RPM Fusion free and non-free repositories
# and installs multimedia codecs for Fedora.
# -------------------------------------------------------

source "$(dirname "${BASH_SOURCE[0]}")/../lib/logging.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../lib/functions.sh"

if package_status "rpmfusion-free-release"; then
    log_info "RPM Fusion repositories are already installed."
else
    log_info "Adding RPM Fusion (free and non-free) repositories..."
    sudo dnf install --assumeyes \
      "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
      "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

    log_info "Installing multimedia codecs..."
    sudo dnf install --assumeyes intel-media-driver libavcodec-freeworld pipewire-codec-aptx ffmpegthumbnailer
fi

