#!/usr/bin/env bash

echo -e "\n\nInstall Postman from Copr repo\n"
sudo dnf copr enable --assumeyes coder966/postman
sudo dnf install --assumeyes openssl postman