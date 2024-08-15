#!/usr/bin/env bash

status=$(package_status "postman")
if [ "$status" -ne 0 ]; then
  echo -e "\n\nInstall Postman from Copr repo\n"
  sudo dnf copr enable --assumeyes coder966/postman
  sudo dnf install --assumeyes openssl postman
else
  echo -e "\nPostman already installed!\n"
fi

