#!/usr/bin/env bash

status=$(package_status "mise")
if [ "$status" -ne 0 ]; then
  echo -e "\n\nInstall Mise from official repository\n"
  sudo dnf config-manager --add-repo https://mise.jdx.dev/rpm/mise.repo
  sudo dnf install --assumeyes mise

  mise use -g -y operator-sdk
  mise use -g -y argocd
  mise use -g -y helm
  mise use -g -y oc
  mise use -g -y kubectl
  mise use -g -y k9s
  mise use -g -y hugo
  mise use -g -y java@temurin-23
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

  mise install -y java@temurin-17
else
  echo -e "Mise is already installed\n"
fi
