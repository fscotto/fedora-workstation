#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# -------------------------------------------------------
# JetBrains Tools Installer Script for Fedora
#
# Enables the COPR repository and installs:
# - IntelliJ IDEA Ultimate Edition
# - PyCharm Community Edition
# -------------------------------------------------------

# Load shared libraries
source "$(dirname "${BASH_SOURCE[0]}")/../lib/logging.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../lib/functions.sh"

log_info "Enabling JetBrains COPR repository..."
sudo dnf copr enable --assumeyes medzik/jetbrains
log_debug "COPR repository 'medzik/jetbrains' enabled."

log_info "Installing IntelliJ IDEA Ultimate and PyCharm Community Edition..."
sudo dnf install --assumeyes intellij-idea-ultimate pycharm-community

log_info "JetBrains IDEs installed successfully."

