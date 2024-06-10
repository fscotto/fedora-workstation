#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
MY_HOME="$HOME"

echo -e "Script directory is $SCRIPT_DIR\n"
echo -e "Home directory is $MY_HOME\n"

rpm-ostree cancel

echo -e "Add RPM Fusion (free and non-free) repositories\n"
sudo rpm-ostree install --assumeyes --idempotent\
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm\
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo rpm-ostree apply-live

echo -e "Install layered packages\n"
rpm-ostree install -A --assumeyes --idempotent "$(cat "$SCRIPT_DIR/data/silverblue-pkg.txt")"

echo -e "Remove Firefox from image\n"
rpm-ostree override remove firefox-langpacks firefox

echo -e "Remove GNOME Terminal from image\n"
rpm-ostree override remove gnome-terminal-nautilus gnome-terminal

sudo rpm-ostree apply-live

echo -e "Add Flathub repository\n"
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo -e "Installing Flatpak packages\n"
while read -r pkg; do
    flatpak install --assumeyes flathub "$pkg"
done < "$SCRIPT_DIR/data/flatpak.txt"

mkdir -p ~/.local/bin/

# TODO configure and export apps and binaries from Distrobox's container
echo -e "Create Archlinux container\n"
distrobox create -n arch -i quay.io/toolbox/arch-toolbox:latest -H "$HOME/.local/share/distrobox/home/arch" --no-entry -Y
distrbox-enter arch -- yes | sudo pacman -Syu
distrobox-enter arch -- git clone https://aur.archlinux.org/paru.it &&\
    cd paru &&\
    makepkg -si
distrobox-enter arch -- yes | paru -S lazygit lazydocker k9s kubectl
distrobox-enter arch -- distrobox-export --bin /usr/bin/lazygit --export-path "$MY_HOME/.local/bin"
distrobox-enter arch -- distrobox-export --bin /usr/bin/lazydocker --export-path "$MY_HOME/.local/bin"
distrobox-enter arch -- distrobox-export --bin /usr/bin/k9s --export-path "$MY_HOME/.local/bin"
distrobox-enter arch -- distrobox-export --bin /usr/bin/kubectl --export-path "$MY_HOME/.local/bin"

echo -e "Create Fedora 40 container\n"
distrobox create -n fedora40 -i registry.fedoraproject.org/fedora-toolbox:40 --no-entry -Y
distrobox-enter fedora40 -- sudo dnf upgrade --assumeyes
distrobox-enter fedora40 -- sudo dnf copr enable atim/starship --assumeyes && sudo dnf install starship --assumeyes
distrobox-enter fedora40 -- distrobox-export --bin /usr/bin/starship --export-path "$MY_HOME/.local/bin"

# TODO Copy dotfiles

# TODO install all GNOME extensions

# TODO Restore DConf settings

rpm-ostree update
#sudo systemctl reboot
