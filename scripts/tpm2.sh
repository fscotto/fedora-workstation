#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

function get_luks_device() {
    # Cerca il device LUKS2 montato come root
    root_device=$(findmnt -n -o SOURCE /)
    # Verifica se è LUKS2 (puoi affinare il controllo)
    if cryptsetup isLuks "$root_device"; then
        echo "$root_device"
    else
        echo ""
    fi
}

function configure_tpm_module() {
    luks2_device=$(get_luks_device)
    if [[ -z "$luks2_device" ]]; then
        echo "No LUKS device found for root filesystem."
        exit 1
    fi

    echo -e "Configuring TPM2 for unlocking LUKS partition $luks2_device\n"

    echo 'add_dracutmodules+=" tpm2-tss "' | sudo tee /etc/dracut.conf.d/tpm2.conf
    echo 'add_dracutmodules+=" bluetooth "' | sudo tee /etc/dracut.conf.d/bluetooth.conf

    sudo systemd-cryptenroll --wipe-slot tpm2 --tpm2-device auto --tpm2-pcrs "7" "$luks2_device"

    sudo cp /etc/crypttab /etc/crypttab.bak

    # Aggiorna solo la linea che contiene il device luks2_device
    # Aggiunge l'opzione solo se non presente
    if ! grep -q "tpm2-device=auto" /etc/crypttab; then
        sudo sed -i "/$luks2_device/ s/$/ tpm2-device=auto,tpm2-pcrs=0+1+2+3+4+5+7+9/" /etc/crypttab
    else
        echo "Options for TPM2 already set in /etc/crypttab"
    fi

    sudo dracut --force --verbose
}

if [[ -c /dev/tpm0 ]] || [[ -d /sys/class/tpm/tpm0 ]]; then
    echo -e "TPM available\n"
    while true; do
        read -r -p "Do you want to configure TPM chip? (Y/N): " answer
        case $answer in
            [Yy]* ) configure_tpm_module; break;;
            [Nn]* ) echo "Skipping TPM configuration."; break;;
            * ) echo "Please answer Y or N.";;
        esac
    done
else
    echo -e "TPM device not found.\n"
fi

