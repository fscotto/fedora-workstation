#!/usr/bin/env bash

status=$(package_status "code")
if [ "$status" -ne 0 ]; then
  echo -e "\n\nAdd Visual Studio Code official repository\n"
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  printf "[vscode]\nname=packages.microsoft.com\nbaseurl=https://packages.microsoft.com/yumrepos/vscode/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscode.repo

  echo -e "\nInstall Visual Studio Code\n"
  sudo dnf install --assumeyes code
else
  echo -e "\nVisual Studio Code already installed\n"
fi

echo -e "Install Visual Studio Code Extensions\n"

code --install-extension redhat.ansible 2>/dev/null
code --install-extension formulahendry.auto-close-tag 2>/dev/null
code --install-extension ms-vscode.cpptools 2>/dev/null
code --install-extension franneck94.vscode-rust-extension-pack 2>/dev/null
code --install-extension mikestead.dotenv 2>/dev/null
code --install-extension jakebecker.elixir-ls 2>/dev/null
code --install-extension golang.go 2>/dev/null
code --install-extension rusnasonov.vscode-hugo 2>/dev/null
code --install-extension budparr.language-hugo-vscode 2>/dev/null
code --install-extension DavidAnson.vscode-markdownlint 2>/dev/null
code --install-extension christian-kohler.path-intellisense 2>/dev/null
code --install-extension esbenp.prettier-vscode 2>/dev/null
code --install-extension ms-python.python 2>/dev/null
code --install-extension ms-python.debugpy 2>/dev/null
code --install-extension timonwong.shellcheck 2>/dev/null
code --install-extension redhat.vscode-xml 2>/dev/null
code --install-extension redhat.vscode-yaml 2>/dev/null
code --install-extension catppuccin.catppuccin-vsc-pack 2>/dev/null
code --install-extension ms-vscode.makefile-tools 2>/dev/null

cat <<EOF >~/.config/Code/User/settings.json
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
