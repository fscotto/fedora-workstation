#!/usr/bin/env bash

echo -e "\n\nInstall SDKMan\n"
curl -s "https://get.sdkman.io" | bash
source "$HOME"/.sdkman/bin/sdkman-init.sh

yes | sdk install java 17.0.10-tem
yes | sdk install maven
yes | sdk install quarkus
yes | sdk install springboot