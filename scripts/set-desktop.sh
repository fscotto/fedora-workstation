#!/usr/bin/env bash

echo -e "Restore GNOME preferences\n"
dconf load < "$SCRIPT_DIR"/fedora.rc