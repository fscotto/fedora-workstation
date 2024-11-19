#!/usr/bin/env bash

status=$(package_status "mise")
if [ "$status" -ne 0 ]; then
  echo -e "\n\nInstall Mise from official repository\n"
  sudo dnf config-manager --add-repo https://mise.jdx.dev/rpm/mise.repo
  sudo dnf install --assumeyes mise
else
  echo -e "Mise is already installed\n"
fi

echo -e "Install Mise plugins"
mise use -g -y operator-sdk
mise use -g -y argocd
mise use -g -y helm
mise use -g -y oc
mise use -g -y kubectl
mise use -g -y k9s
mise use -g -y hugo
mise use -g -y java
mise use -g -y quarkus
mise use -g -y spring-boot
mise use -g -y jmeter
mise use -g -y node
mise use -g -y go
mise use -g -y maven
mise use -g -y minikube
mise use -g -y task
mise use -g -y glab
mise use -g -y gh
mise use -g -y lazygit
mise use -g -y lua
mise plugins install lazydocker https://github.com/comdotlinux/asdf-lazydocker.git
mise use -g -y lazydocker
mise use -g -y go:github.com/walles/moar
mise use -g -y go:github.com/charmbracelet/glow
mise use -g -y cargo:yazi-cli
mise use -g -y cargo:yazi-fm

mise install -y java@temurin-17
mise install -y python@3.12

asdf_home="$HOME/.asdf"
if [ -d "$asdf_home" ]; then
  mv "$asdf_home" "$asdf_home.old"
elif [ -e "$asdf_home" ]; then
  rm -f "$asdf_home"
fi

ln -s "$asdf_home" "$asdf_home"
