#!/usr/bin/env bash

sudo tee -a /etc/pki/tls/openssl.cnf << EOF

[openssl_init]
ssl_conf = ssl_sect

[ssl_sect]
system_default = system_default_sect

[system_default_sect]
Options = UnsafeLegacyRenegotiation
EOF