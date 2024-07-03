#!/usr/bin/env bash

echo -e "\n\nInstall Intellij Ultimate Edition from Copr repo\n"
sudo dnf copr enable --assumeyes coder966/intellij-idea-ultimate
sudo dnf install --assumeyes intellij-idea-ultimate