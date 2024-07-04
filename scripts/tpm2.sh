#!/usr/bin/env bash

# Instruction from https://fedoramagazine.org/use-systemd-cryptenroll-with-fido-u2f-or-tpm2-to-decrypt-your-disk/

# FIXME: select LUKS2 device in automatic way
luks2_device="/dev/nvme0n1p3"

echo -e "Configure TPM2 for unlock LUKS partition\n"
echo "add_dracutmodules+=\" tpm2-tss \"" | sudo tee /etc/dracut.conf.d/tpm2.conf
echo "add_dracutmodules+=\" bluetooth \"" | sudo tee /etc/dracut.conf.d/bluetooth.conf

sudo systemd-cryptenroll --wipe-slot tpm2 --tpm2-device auto --tpm2-pcrs "0+1+2+3+4+5+7+9" "$luks2_device"

# Update /etc/crypttab and append tpm2-device=auto,tpm2-pcrs=0+1+2+3+4+5+7+9 to the appropriate line’s options, depending on the PCRs used.
sudo cp /etc/crypttab /etc/crypttab.bak
sudo sed -e 's/$/ tpm2-device=auto,tpm2-pcrs=0+1+2+3+4+5+7+9/' -i crypttab

sudo dracut -f
