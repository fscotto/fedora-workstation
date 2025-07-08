#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

OPENSSL_CONF=/etc/pki/tls/openssl.cnf
BACKUP_CONF="/etc/pki/tls/openssl.cnf.bak.$(date +%Y%m%d%H%M%S)"

echo "Checking if OpenSSL legacy renegotiation is already enabled..."

# Controlla se la configurazione è già presente (cerca in modo più preciso)
if sudo grep -Pzo "\[system_default_sect\][^\[]*Options\s*=\s*UnsafeLegacyRenegotiation" "$OPENSSL_CONF" > /dev/null; then
  echo "OpenSSL legacy renegotiation is already enabled."
  exit 0
fi

echo "Backing up original OpenSSL config to $BACKUP_CONF"
sudo cp "$OPENSSL_CONF" "$BACKUP_CONF"

echo -e "\nEnabling OpenSSL legacy renegotiation..."
sudo tee -a "$OPENSSL_CONF" > /dev/null <<EOF

# Enable legacy renegotiation
[openssl_init]
ssl_conf = ssl_sect

[ssl_sect]
system_default = system_default_sect

[system_default_sect]
Options = UnsafeLegacyRenegotiation
EOF

echo "OpenSSL legacy renegotiation enabled successfully."

