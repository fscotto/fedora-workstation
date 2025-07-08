#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# -------------------------------------------------------
# Mise Installer Script for Fedora
#
# Installs Mise from the official repository, sets up
# plugins for various tools and runtimes, and ensures
# cleanup of potential ASDF conflicts.
# -------------------------------------------------------

# Load shared libraries
source "$(dirname "${BASH_SOURCE[0]}")/../lib/logging.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../lib/functions.sh"

# Check if Mise is already installed
if package_status "mise"; then
    log_info "Mise is already installed. Skipping base installation."
else
    log_info "Installing Mise from official repository..."
    sudo dnf config-manager --add-repo https://mise.jdx.dev/rpm/mise.repo
    sudo dnf install --assumeyes mise
    log_info "Mise installation completed."
fi

# Define plugin list
declare -a plugins=(
    operator-sdk
    argocd
    helm
    oc
    kubectl
    k9s
    hugo
    java
    quarkus
    spring-boot
    jmeter
    node
    go
    maven
    minikube
    task
    glab
    gh
    lazygit
    lua
)

log_info "Installing core Mise plugins and tools..."
for plugin in "${plugins[@]}"; do
    log_debug "Installing: $plugin"
    mise use -g -y "$plugin"
done

# Install community plugin for lazydocker
log_info "Installing community plugin: lazydocker"
mise plugins install lazydocker https://github.com/comdotlinux/asdf-lazydocker.git
mise use -g -y lazydocker

# Install specific Go/Cargo-based tools
log_info "Installing additional tools via Go and Cargo through Mise"
mise use -g -y go:github.com/walles/moar
mise use -g -y go:github.com/charmbracelet/glow
mise use -g -y cargo:yazi-cli
mise use -g -y cargo:yazi-fm

# Install pinned versions
log_info "Installing pinned versions of Java and Python"
mise install -y java@temurin-17
mise install -y python@3.12

# Handle potential ASDF directory conflicts
asdf_home="$HOME/.asdf"
if [ -d "$asdf_home" ]; then
    log_warn "Old ASDF directory found. Renaming to .asdf.old"
    mv "$asdf_home" "$asdf_home.old"
elif [ -e "$asdf_home" ]; then
    log_warn "Conflicting ASDF file found. Removing."
    rm -f "$asdf_home"
fi

# Optional symlink fix or placeholder action (commented to avoid error)
# ln -s <target> <link_name>
# Uncomment and fix if a specific symlink is needed
# ln -s "$SOME_VALID_TARGET" "$asdf_home"

log_info "Mise setup completed successfully."

