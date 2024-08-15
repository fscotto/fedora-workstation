#!/usr/bin/env bash

status=$(package_status "docker-ce")
if [ "$status" -ne 0 ]; then
  echo -e "\n\nInstall Docker\n"
  sudo dnf install --assumeyes dnf-plugins-core
  sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
  sudo dnf install --assumeyes docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  echo -e "Configure user ${USER} with docker group\n"
  sudo usermod -aG docker "${USER}"

  echo -e "Log out of session to make changes effective\n"

  echo -e "Enable Systemd Docker service\n"
  sudo systemctl enable --now docker.service
else
  echo -e "\nDocker already installed!\n"
fi
