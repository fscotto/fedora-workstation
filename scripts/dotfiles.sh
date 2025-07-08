#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# -------------------------------------------------------
# Dotfiles Setup Script
#
# Installs GNU Stow if missing,
# clones dotfiles repo if needed,
# and deploys configuration packages with stow.
# Also clones Bash Git Prompt for enhanced shell.
# -------------------------------------------------------

# Load shared libraries
source "$(dirname "${BASH_SOURCE[0]}")/../lib/logging.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../lib/functions.sh"

DOTFILES_LOC="$HOME/.dotfiles"
CONFIG_DIR="$HOME/.config"

# Ensure GNU Stow is installed
if package_status "stow"; then
    log_info "GNU Stow is already installed."
else
    log_info "Installing GNU Stow for dotfiles management..."
    sudo dnf install --assumeyes stow
fi

# Clone dotfiles repository if missing
if [ ! -d "$DOTFILES_LOC" ]; then
    log_info "Cloning dotfiles repository to $DOTFILES_LOC..."
    git clone --recursive https://github.com/fscotto/dotfiles.git "$DOTFILES_LOC"
else
    log_info "Dotfiles directory already exists at $DOTFILES_LOC."
fi

# List of configuration packages to stow
packages=(
  "bat"
  "btop"
  "fastfetch"
  "fish"
  "git"
  "k9s"
  "kitty"
  "lazydocker"
  "lazygit"
  "nvim"
  "ov"
  "starship"
  "tmux"
  "yazi"
)

log_info "Deploying dotfiles packages with GNU Stow..."
for pkg in "${packages[@]}"; do
    absolute_pkg_path="${CONFIG_DIR}/${pkg}"
    if [ -d "$absolute_pkg_path" ] && [ ! -L "$absolute_pkg_path" ]; then
        log_warn "Directory $absolute_pkg_path exists and is not a symlink. Removing to allow stow deployment."
        rm -rf "$absolute_pkg_path"
    fi

    log_debug "Stowing package: $pkg"
    stow --dotfiles --dir "$DOTFILES_LOC" -R "$pkg"
done

# Clone Bash Git Prompt if missing
if [ ! -d "$HOME/.bash-git-prompt" ]; then
    log_info "Cloning Bash Git Prompt for enhanced bash shell prompt..."
    git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
else
    log_info "Bash Git Prompt already cloned."
fi

log_info "Dotfiles setup completed successfully."

