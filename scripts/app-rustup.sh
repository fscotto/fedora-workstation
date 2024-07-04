#!/usr/bin/env bash

sudo dnf install --assumeyes rustup

rustup toolchain add stable
rustup toolchain add nightly