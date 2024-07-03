#!/usr/bin/env bash

echo -e "Add RPM Fusion (free and non-free) repositories\n"
sudo dnf install --assumeyes https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo -e "Install multimedia codecs\n"
sudo dnf install --assumeyes intel-media-driver libavcodec-freeworld pipewire-codec-aptx