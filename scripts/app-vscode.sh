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
  code --install-extension "$ext" 2>/dev/null
done

cat <<EOF >~/.config/Code/User/settings.json
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
    "files.autoSave": "afterDelay",
}
EOF
