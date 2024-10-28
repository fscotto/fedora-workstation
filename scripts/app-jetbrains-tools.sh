#!/usr/bin/env bash

echo -e "\n\nInstall Intellij Ultimate Edition and PyCharm Community Edition from Copr repo\n"
sudo dnf copr enable --assumeyes medzik/jetbrains
sudo dnf install --assumeyes intellij-idea-ultimate pycharm-community
