#!/usr/bin/env bash

sudo dnf install --assumeyes gcc gcc-c++ gmp gmp-devel make ncurses ncurses-compat-libs xz perl
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
