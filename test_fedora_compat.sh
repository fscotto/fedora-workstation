#!/usr/bin/env bash
set -euo pipefail

echo "=== Fedora 41/42 Compatibility Test Script ==="
echo "Running on $(cat /etc/fedora-release)"
echo ""

# Check basic package manager functionality
echo "Checking dnf is functional..."
dnf check-update > /dev/null && echo "dnf OK" || echo "dnf error"

# Check Fedora version
FEDORA_VER=$(rpm -E %fedora)
echo "Detected Fedora version: $FEDORA_VER"

# Check key packages installed or available
declare -a pkgs=(
  stow
  flatpak
  gnome-extensions-cli
  rpmfusion-free-release
  intel-media-driver
  openssl
  systemd
  dracut
  gsettings
)

echo "Checking essential packages..."
for pkg in "${pkgs[@]}"; do
  if dnf list installed "$pkg" &>/dev/null; then
    echo "Package $pkg: INSTALLED"
  else
    echo "Package $pkg: NOT INSTALLED"
  fi
done
echo ""

# Check GNOME gsettings keys (some examples)
declare -A gsettings_checks=(
  ["org.gnome.desktop.interface clock-show-weekday"]="true"
  ["org.gnome.desktop.interface color-scheme"]="prefer-dark"
  ["org.gnome.shell favorite-apps"]="['org.gnome.Nautilus.desktop', 'org.mozilla.firefox.desktop']"
)

echo "Checking GNOME settings keys..."
for key in "${!gsettings_checks[@]}"; do
  expected="${gsettings_checks[$key]}"
  actual=$(gsettings get "$key" 2>/dev/null || echo "KEY_NOT_FOUND")
  if [[ "$actual" == "$expected" ]]; then
    echo "Key $key: OK"
  else
    echo "Key $key: MISMATCH (expected $expected, got $actual)"
  fi
done
echo ""

# Check TPM device presence
TPM_PATH=$(ls -d /sys/kernel/security/tpm* 2>/dev/null | head -1 || echo "")
if [[ -n "$TPM_PATH" ]]; then
  echo "TPM device detected: $TPM_PATH"
else
  echo "TPM device NOT detected"
fi
echo ""

# Check OpenSSL legacy renegotiation config presence
OPENSSL_CONF=/etc/pki/tls/openssl.cnf
if grep -q UnsafeLegacyRenegotiation "$OPENSSL_CONF"; then
  echo "OpenSSL legacy renegotiation ENABLED in $OPENSSL_CONF"
else
  echo "OpenSSL legacy renegotiation NOT enabled in $OPENSSL_CONF"
fi
echo ""

# Check RPM Fusion repo enabled
if dnf repolist enabled | grep -q rpmfusion; then
  echo "RPM Fusion repositories are ENABLED"
else
  echo "RPM Fusion repositories NOT enabled"
fi
echo ""

# Check Flatpak remote 'flathub' present
if flatpak remote-list | grep -q flathub; then
  echo "Flathub Flatpak remote is present"
else
  echo "Flathub Flatpak remote is NOT present"
fi
echo ""

echo "=== Test complete ==="

