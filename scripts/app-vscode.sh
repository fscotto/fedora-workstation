#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# -------------------------------------------------------
# Visual Studio Code Installer Script for Fedora
#
# Adds the official Microsoft VS Code repository,
# installs VS Code if not already installed,
# installs a curated list of VS Code extensions,
# and writes user settings JSON configuration.
# -------------------------------------------------------

# Load shared libraries
source "$(dirname "${BASH_SOURCE[0]}")/../lib/logging.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../lib/functions.sh"

# Check if VS Code is installed
if package_status "code"; then
    log_info "Visual Studio Code is already installed. Skipping installation."
else
    log_info "Adding Visual Studio Code official repository..."
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

    sudo tee /etc/yum.repos.d/vscode.repo > /dev/null <<EOF
[vscode]
name=packages.microsoft.com
baseurl=https://packages.microsoft.com/yumrepos/vscode/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
metadata_expire=1h
EOF

    log_info "Installing Visual Studio Code..."
    sudo dnf install --assumeyes code
fi

log_info "Installing Visual Studio Code extensions..."

extensions=(
  "budparr.language-hugo-vscode"
  "catppuccin.catppuccin-vsc"
  "catppuccin.catppuccin-vsc-icons"
  "catppuccin.catppuccin-vsc-pack"
  "christian-kohler.path-intellisense"
  "davidanson.vscode-markdownlint"
  "esbenp.prettier-vscode"
  "fill-labs.dependi"
  "formulahendry.auto-close-tag"
  "golang.go"
  "mikestead.dotenv"
  "ms-azuretools.vscode-docker"
  "ms-vscode-remote.remote-containers"
  "ms-vscode.cmake-tools"
  "ms-vscode.cpptools"
  "ms-vscode.cpptools-extension-pack"
  "ms-vscode.cpptools-themes"
  "ms-vscode.makefile-tools"
  "redhat.ansible"
  "redhat.vscode-tekton-pipelines"
  "redhat.vscode-xml"
  "redhat.vscode-yaml"
  "rusnasonov.vscode-hugo"
  "timonwong.shellcheck"
  "twxs.cmake"
  "xaver.clang-format"
  "pinage404.bash-extension-pack"
  "haskell.haskell"
)

for ext in "${extensions[@]}"; do
    log_debug "Installing extension: $ext"
    code --install-extension "$ext" 2>/dev/null || log_warn "Failed to install extension: $ext"
done

log_info "Writing Visual Studio Code user settings..."

mkdir -p ~/.config/Code/User

cat > ~/.config/Code/User/settings.json <<'EOF'
{
    "workbench.startupEditor": "none",
    "workbench.iconTheme": "catppuccin-frappe",
    "workbench.colorTheme": "Catppuccin Frappé",
    "window.titleBarStyle": "custom",

    "editor.fontFamily": "'FiraCode Nerd Font'",
    "editor.fontSize": 20,

    // Terminal configurations
    "terminal.external.linuxExec": "kitty",
    "terminal.integrated.gpuAcceleration": "on",
    "terminal.integrated.defaultProfile.linux": "fish",
    "terminal.integrated.cursorBlinking": true,
    "terminal.integrated.fontFamily": "'FiraCode Nerd Font'",
    "terminal.integrated.fontSize": 20,

    "redhat.telemetry.enabled": false,
    "[c]": {
        "editor.defaultFormatter": "xaver.clang-format"
    },
    "git.autofetch": true,
    "[javascript]": {
        "editor.defaultFormatter": "vscode.typescript-language-features"
    },
    "files.autoSave": "afterDelay"
}
EOF

log_info "Visual Studio Code setup completed successfully."

