#!/usr/bin/env bash

sudo dnf install --assumeyes rustup

rustup-init

rustup toolchain add nightly