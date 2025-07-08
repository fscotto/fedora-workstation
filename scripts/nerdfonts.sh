#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# -------------------------------------------------------
# Nerd Fonts Installer Script
#
# Downloads and installs selected Nerd Fonts
# into the system fonts directory if not already present.
# Refreshes font cache at the end.
# -------------------------------------------------------

source "$(dirname "${BASH_SOURCE[0]}")/../lib/logging.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../lib/functions.sh"

FONT_DIR=/usr/share/fonts/nerd-fonts

# Function to check if a font is already installed by searching FONT_DIR
check_installed_font() {
  local font_name="${1}"
  local entries_num
  entries_num=$(find "${FONT_DIR}" -iname "${font_name}*" 2>/dev/null | wc -l)
  (( entries_num > 0 )) && echo "Y" || echo "N"
}

log_info "Starting Nerd Fonts installation..."

sudo mkdir -p "${FONT_DIR}"
cd /tmp || { log_error "Failed to change directory to /tmp"; exit 1; }

declare -A fonts=(
  ["RobotoMono"]="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/RobotoMono.zip"
  ["JetBrainsMono"]="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip"
  ["FiraCode"]="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip"
)

for font in "${!fonts[@]}"; do
  if [[ "$(check_installed_font "$font")" == "N" ]]; then
    url="${fonts[$font]}"
    log_info "Downloading and installing Nerd Font: $font"
    wget -q "$url" -O "${font}.zip"
    unzip -q "${font}.zip" -d "${font}"
    sudo mv -v "${font}" "${FONT_DIR}/"
    rm -f "${font}.zip"
  else
    log_info "Nerd Font $font already installed. Skipping."
  fi
done

log_info "Updating font cache..."
sudo fc-cache -fv

cd - >/dev/null || exit
log_info "Nerd Fonts installation completed."

