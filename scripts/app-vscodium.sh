#!/usr/bin/env bash

echo -e "\n\nAdd VSCodium official repository\n"
sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo

echo -e "\nInstall VSCodium\n"
sudo dnf install --assumeyes codium

echo -e "Install VSCodium Extensions\n"

set +e

codium --install-extension piousdeer.adwaita-theme &>/dev/null
codium --install-extension redhat.ansible &>/dev/null
codium --install-extension formulahendry.auto-close-tag &>/dev/null
codium --install-extension bungcip.better-toml &>/dev/null
codium --install-extension franneck94.vscode-rust-extension-pack &>/dev/null
codium --install-extension mikestead.dotenv &>/dev/null
codium --install-extension elixir-lsp.elixir-ls &>/dev/null
codium --install-extension golang.go &>/dev/null
codium --install-extension rusnasonov.vscode-hugo &>/dev/null
codium --install-extension budparr.language-hugo-vscode &>/dev/null
codium --install-extension DavidAnson.vscode-markdownlint &>/dev/null
codium --install-extension christian-kohler.path-intellisense &>/dev/null
codium --install-extension esbenp.prettier-vscode &>/dev/null
codium --install-extension ms-python.python &>/dev/null
codium --install-extension ms-python.debugpy &>/dev/null
codium --install-extension timonwong.shellcheck &>/dev/null
codium --install-extension redhat.vscode-xml &>/dev/null
codium --install-extension redhat.vscode-yaml &>/dev/null

cat << EOF > ~/.config/VSCodium/User/settings.json
{
    "workbench.startupEditor": "none",
    "workbench.iconTheme": "material-icon-theme",
    "workbench.colorTheme": "Adwaita Dark",
    "window.titleBarStyle": "custom",

    "editor.fontFamily": "'JetBrainsMono Nerd Font', 'FiraCode Nerd Font'",
    "editor.fontSize": 18,
    
    // Terminal configurations
    "terminal.external.linuxExec": "gnome-terminal",
    "terminal.integrated.gpuAcceleration": "on",
    "terminal.integrated.defaultProfile.linux": "fish",
    "terminal.integrated.cursorBlinking": true,
    "terminal.integrated.fontFamily": "'RobotoMono Nerd Font'",
    "terminal.integrated.fontSize": 18,

    "redhat.telemetry.enabled": false,
    "elixirLS.enableTestLenses": true,
    "elixirLS.fetchDeps": true,
}
EOF

set -e