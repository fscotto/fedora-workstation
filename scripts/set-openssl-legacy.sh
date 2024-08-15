#!/usr/bin/env bash

OPENSSL_CONF=/etc/pki/tls/openssl.cnf

# Check if already UnsafeLegacyRenegotiation is enabled
if ! grep -q "UnsafeLegacyRenegotiation" "${OPENSSL_CONF}"; then
  echo -e "\n\nEnable OpenSSL legacy renegotiation"
  sudo tee -a "${OPENSSL_CONF}" <<EOF

# Enable legacy renegotiation
[openssl_init]
ssl_conf = ssl_sect

[ssl_sect]
system_default = system_default_sect

[system_default_sect]
Options = UnsafeLegacyRenegotiation
EOF
else
  echo -e "\nOpenSSL legacy renegotiation is already enabled."
fi

