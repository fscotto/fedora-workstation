#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
MY_HOME="$HOME"

echo -e "Script directory is $SCRIPT_DIR\n"
echo -e "Home directory is $MY_HOME\n"

sudo dnf upgrade --assumeyes

echo -e "Add RPM Fusion (free and non-free) repositories\n"
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo -e "Add third party repositories from Copr\n"
sudo dnf copr enable --assumeyes varlad/zellij
sudo dnf copr enable --assumeyes atim/starship
sudo dnf copr enable --assumeyes coder966/postman
sudo dnf copr enable --assumeyes coder966/intellij-idea-ultimate

# Add official repository for VSCodium
sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo

echo -e "Install Fedora packages\n"
sudo dnf install --assumeyes "$(cat "$SCRIPT_DIR/data/fedora-pkg.txt")"

echo -e "Remove Firefox from image\n"
sudo dnf remove --assumeyes firefox-langpacks firefox

echo -e "Add Flathub repository\n"
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo -e "Installing Flatpak packages\n"
while read -r pkg; do
    flatpak install --assumeyes flathub "$pkg"
done < "$SCRIPT_DIR/data/flatpak.txt"

mkdir -p ~/.local/bin/

# Copy dotfiles
configs=("bat" "fastfetch" "fish" "nvim" "ranger" "starship.toml")
git clone https://github.com/fscotto/dotfiles.git
for f in "${configs[@]}"; do 
    rsync -avxHAWX --delete --fsync "$SCRIPT_DIR/dotfiles/$f" "$HOME/.config"    
done

dotfiles=(".gitignore_global" ".gitconfig")
for f in "${dotfiles[@]}"; do
    rsync -avxHAWX --delete --fsync "$SCRIPT_DIR/dotfiles/$f" "$HOME" 
done

# TODO install all GNOME extensions

# TODO Restore DConf settings

echo -e "Apply all setting reboot your computer"
