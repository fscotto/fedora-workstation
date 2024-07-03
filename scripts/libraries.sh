#!/usr/bin/env bash

echo -e "Install libraries for C development\n"
sudo dnf groupinstall --assumeyes 'C Development Tools and Libraries'