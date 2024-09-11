#!/usr/bin/env bash

status=$(package_status "codium")
if [ "$status" -ne 0 ]; then
  echo -e "\n\nAdd VSCodium official repository\n"
  sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
  printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo

  echo -e "\nInstall VSCodium\n"
  sudo dnf install --assumeyes codium

  echo -e "Install VSCodium Extensions\n"

  set +e

  codium --install-extension redhat.ansible 2>/dev/null
  codium --install-extension formulahendry.auto-close-tag 2>/dev/null
  codium --install-extension bungcip.better-toml 2>/dev/null
  codium --install-extension franneck94.vscode-rust-extension-pack 2>/dev/null
  codium --install-extension mikestead.dotenv 2>/dev/null
  codium --install-extension elixir-lsp.elixir-ls 2>/dev/null
  codium --install-extension golang.go 2>/dev/null
  codium --install-extension rusnasonov.vscode-hugo 2>/dev/null
  codium --install-extension budparr.language-hugo-vscode 2>/dev/null
  codium --install-extension DavidAnson.vscode-markdownlint 2>/dev/null
  codium --install-extension christian-kohler.path-intellisense 2>/dev/null
  codium --install-extension esbenp.prettier-vscode 2>/dev/null
  codium --install-extension ms-python.python 2>/dev/null
  codium --install-extension ms-python.debugpy 2>/dev/null
  codium --install-extension timonwong.shellcheck 2>/dev/null
  codium --install-extension redhat.vscode-xml 2>/dev/null
  codium --install-extension redhat.vscode-yaml 2>/dev/null
  codium --install-extension catppuccin.catppuccin-vsc-pack 2>/dev/null
  codium --install-extension vscodevim.vim 2>/dev/null
  codium --install-extension llvm-vs-code-extensions.vscode-clangd 2>/dev/null

  cat <<EOF >~/.config/VSCodium/User/settings.json
{
    "workbench.startupEditor": "none",
    "workbench.iconTheme": "catppuccin-frappe",
    "workbench.colorTheme": "Catppuccin Frappé",
    "window.titleBarStyle": "custom",

    "editor.fontFamily": "'FiraCode Nerd Font'",
    "editor.fontSize": 16,
    
    // Terminal configurations
    "terminal.external.linuxExec": "kitty",
    "terminal.integrated.gpuAcceleration": "on",
    "terminal.integrated.defaultProfile.linux": "fish",
    "terminal.integrated.cursorBlinking": true,
    "terminal.integrated.fontFamily": "'FiraCode Nerd Font'",
    "terminal.integrated.fontSize": 16,

    "redhat.telemetry.enabled": false,
    "elixirLS.enableTestLenses": true,
    "elixirLS.fetchDeps": true,
}
EOF

  set -e
else
  echo -e "\nVSCodium already installed\n"
fi
