curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk install java 17.0.11-graal
sdk install java 22.0.1-graalce
sdk install java 8.0.412-tem
sdk install java 17.0.9-tem

sdk install maven
sdk install quarkus
sdk install springboot
