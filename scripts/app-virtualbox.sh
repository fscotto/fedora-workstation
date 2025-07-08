#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# -------------------------------------------------------
# VirtualBox Installer Script for Fedora
#
# Installs required build tools and kernel headers,
# sets up VirtualBox official repository,
# installs VirtualBox and extension pack,
# creates signing keys and helper script for kernel modules,
# and instructs user on post-install steps.
# -------------------------------------------------------

# Load shared libraries
source "$(dirname "${BASH_SOURCE[0]}")/../lib/logging.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../lib/functions.sh"

SIGN_MODULE_PATH=/var/lib/shim-signed/mok
EXTPACK_VERSION="7.1.2"
EXTPACK_FILE="Oracle_VirtualBox_Extension_Pack-${EXTPACK_VERSION}.vbox-extpack"

log_info "Installing build dependencies for VirtualBox..."
sudo dnf install --assumeyes @development-tools
sudo dnf install --assumeyes kernel-headers kernel-devel dkms

log_info "Adding VirtualBox official repository..."
sudo tee /etc/yum.repos.d/virtualbox.repo > /dev/null <<EOF
[virtualbox]
name=Fedora \$releasever - \$basearch - VirtualBox
baseurl=http://download.virtualbox.org/virtualbox/rpm/fedora/\$releasever/\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.virtualbox.org/download/oracle_vbox_2016.asc
EOF

log_info "Updating package cache..."
sudo dnf update --assumeyes

log_info "Installing VirtualBox 7.1..."
sudo dnf install --assumeyes VirtualBox-7.1

log_info "Adding user '${USER}' to vboxusers group..."
sudo usermod -aG vboxusers "$USER"

log_info "Downloading VirtualBox Extension Pack version ${EXTPACK_VERSION}..."
wget -q "https://download.virtualbox.org/virtualbox/${EXTPACK_VERSION}/${EXTPACK_FILE}"

log_info "Installing VirtualBox Extension Pack..."
sudo vboxmanage extpack install --replace "${EXTPACK_FILE}"

log_info "Cleaning up Extension Pack file..."
rm -f "${EXTPACK_FILE}"

log_info "Creating directory for module signing keys: ${SIGN_MODULE_PATH}"
sudo mkdir -p "$SIGN_MODULE_PATH"

log_info "Generating signing keys..."
cd "$SIGN_MODULE_PATH"
sudo openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform DER -out MOK.der -nodes -days 36500 -subj "/CN=VirtualBox/"
sudo chmod 600 MOK.priv

log_info "Importing MOK key..."
sudo mokutil --import MOK.der

log_info "Creating signing script for VirtualBox kernel modules..."
sudo tee "$SIGN_MODULE_PATH/sign-virtualbox" > /dev/null <<'EOF'
#!/bin/bash

MOKPATH=/var/lib/shim-signed/mok

for modfile in $(dirname $(modinfo -n vboxdrv))/*.ko; do
  echo "Signing $modfile"
  /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 \
    "$MOKPATH"/MOK.priv "$MOKPATH"/MOK.der "$modfile"
done
EOF

sudo chmod 700 "$SIGN_MODULE_PATH/sign-virtualbox"

cd - > /dev/null

cat <<EOF

IMPORTANT:
Please reboot your system and enroll the MOK key when prompted.

After reboot, sign VirtualBox modules by running:

  sudo $SIGN_MODULE_PATH/sign-virtualbox

Then load the signed kernel modules with:

  sudo modprobe vboxdrv

VirtualBox setup is complete!

EOF

