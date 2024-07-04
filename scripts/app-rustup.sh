#!/usr/bin/env bash

echo -e "Install Rustup\n"
sudo dnf install --assumeyes rustup

rustup-init
. "$HOME"/.cargo/env

rustup toolchain add nightly