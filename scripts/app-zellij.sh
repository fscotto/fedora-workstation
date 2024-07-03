#!/usr/bin/env bash

echo -e "Install Zellij from Copr repo\n"
sudo dnf copr enable --assumeyes varlad/zellij
sudo dnf install --assumeyes zellij