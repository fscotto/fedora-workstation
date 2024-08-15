#!/usr/bin/env bash

status=$(package_status "rustup")
if [ "$status" -ne 0 ]; then
  echo -e "Install Rustup\n"
  sudo dnf install --assumeyes rustup

  rustup-init
  . "$HOME"/.cargo/env

  rustup toolchain add nightly
else
  echo -e "\nRustup already installed\n"
fi

