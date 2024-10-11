#!/usr/bin/env bash

SIGN_MODULE_PATH=/var/lib/shim-signed/mok

echo -e "\n\nInstall pre-requirements for VirtualBox"
sudo dnf install --assumeyes @development-tools
sudo dnf install --assumeyes kernel-headers kernel-devel dkms

echo -e "Install VirtualBox from official repository"
sudo tee -a /etc/yum.repos.d/virtualbox.repo <<EOF
[virtualbox]
name=Fedora $releasever - $basearch - VirtualBox
baseurl=http://download.virtualbox.org/virtualbox/rpm/fedora/$releasever/$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.virtualbox.org/download/oracle_vbox_2016.asc
EOF

sudo dnf update --assumeyes
sudo dnf install --assumeyes VirtualBox-7.1

echo -e "Adding user $USER to vboxusers group"
sudo usermod -aG vboxusers "$USER"

echo -e "Install VirtualBox Extension Pack"
wget https://download.virtualbox.org/virtualbox/7.1.2/Oracle_VirtualBox_Extension_Pack-7.1.2.vbox-extpack
sudo vboxmanage extpack install Oracle_VirtualBox_Extension_Pack-7.1.2.vbox-extpack
rm Oracle_VirtualBox_Extension_Pack-7.1.2.vbox-extpack

echo -e "Create keys and script for sign modules"
sudo mkdir -p "$SIGN_MODULE_PATH"

cd "$SIGN_MODULE_PATH" || exit
sudo openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform DER -out MOK.der -nodes -days 36500 -subj "/CN=VirtualBox/"
sudo chmod 600 MOK.priv
sudo mokutil --import MOK.der

sudo tee -a "$SIGN_MODULE_PATH"/sign-virtualbox <<EOF
#!/bin/bash

MOKPATH=/var/lib/shim-signed/mok

for modfile in $(dirname $(modinfo -n vboxdrv))/*.ko; do
  echo "Signing $modfile"
  /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 \
  	"$MOKPATH"/MOK.priv "$MOKPATH"/MOK.der "$modfile"
done
EOF

sudo chmod 700 "$SIGN_MODULE_PATH"/sign-virtualbox
cd - || exit

cat <<EOF
Reboot your system and MOK enroll key.
After reboot can you sign modules with script:

  sudo $SIGN_MODULE_PATH/sign-virtualbox

and load all signed modules:

  sudo modprobe vboxdrv

You are done!!!
EOF
