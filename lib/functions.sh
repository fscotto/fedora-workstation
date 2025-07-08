#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Source the advanced logging module
source "$(dirname "${BASH_SOURCE[0]}")/logging.sh"

# -------------------------------------------------------
# Checks whether a given package is installed.
#
# Arguments:
#   $1 - Package name to check
#
# Returns:
#   0 if installed, 1 otherwise
# -------------------------------------------------------
function package_status {
    local pkg="$1"
    log_debug "Checking if package '${pkg}' is installed..."
    if repoquery -a --installed | grep -q "$pkg"; then
        log_info "Package '${pkg}' is installed."
        return 0
    else
        log_warn "Package '${pkg}' is not installed."
        return 1
    fi
}

# -------------------------------------------------------
# Detects the Fedora version from /etc/os-release.
#
# Returns:
#   Echoes the detected version (e.g., "40") or an
#   empty string if not found
# -------------------------------------------------------
function fedora_version {
    local version=""
    local available_versions=("40" "41")

    log_debug "Detecting Fedora version..."
    for v in "${available_versions[@]}"; do
        if grep -w "VERSION" /etc/os-release | grep -q "$v"; then
            version="$v"
            log_info "Detected Fedora version: $version"
            break
        fi
    done

    if [[ -z "$version" ]]; then
        log_error "Unsupported or undetected Fedora version."
    fi

    echo "$version"
}

