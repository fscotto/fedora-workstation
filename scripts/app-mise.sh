#!/usr/bin/env bash

status=$(package_status "mise")
if [ "$status" -ne 0 ]; then
  sudo dnf config-manager --add-repo https://mise.jdx.dev/rpm/mise.repo
  sudo dnf install --assumeyes mise
fi
