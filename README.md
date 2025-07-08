# Fedora Workstation 40+ Post-Installation Setup

> ⚠️ **Disclaimer:** This project is currently in beta and under active development.

---

## Overview

This repository contains a collection of scripts designed to automate the post-installation setup and configuration of Fedora Workstation 40+.  
The goal is to streamline the installation of essential software, system configuration, GNOME customization, and developer environment setup, providing a ready-to-use and polished desktop experience.

---

## Project Structure

- **dotfiles.sh**  
  Manages personal dotfiles installation and symlinking using GNU Stow.

- **flatpak.sh**  
  Adds the Flathub repository, removes conflicting RPM packages (e.g., Firefox), installs a curated set of Flatpak applications, and applies user configuration overrides.

- **libraries.sh**  
  Installs base development tools and libraries for C programming.

- **nerdfonts.sh**  
  Installs popular Nerd Fonts (Roboto Mono, JetBrains Mono, FiraCode) patched with developer icons.

- **rpm-fusion.sh**  
  Enables RPM Fusion free and non-free repositories and installs multimedia codecs.

- **set-gnome-extensions.sh**  
  Installs and configures a selection of GNOME Shell extensions using the GNOME Extensions CLI tool.

- **set-gnome-hotkeys.sh**  
  Defines custom keyboard shortcuts for window management, application launching, and terminal access.

- **set-gnome-preferences.sh**  
  Applies personalized GNOME settings, including themes, icon sets, input sources, Nautilus preferences, workspace behavior, and more.

- **set-openssl-legacy.sh**  
  Enables legacy renegotiation options in OpenSSL configuration to maintain compatibility with legacy services.

- **tpm2.sh**  
  Configures TPM2 support for unlocking LUKS-encrypted partitions securely during boot.

---

## Key Software Installed

### Terminal & Shell Enhancements
- **Kitty:** GPU-accelerated terminal emulator  
- **Fish:** User-friendly interactive shell  
- **Starship:** Cross-shell prompt  
- **Bat:** Enhanced `cat` command with syntax highlighting  

### Development Tools
- **Neovim:** Modern Vim-based text editor  
- **Rustup:** Rust toolchain installer  
- **PyCharm:** Python IDE  
- **IntelliJ IDEA Ultimate:** Full-featured Java IDE  
- **Visual Studio Code:** Source-code editor  

### System Utilities
- **Btop:** System monitoring tool  
- **Fastfetch:** System information tool  
- **Fd:** Fast alternative to `find`  
- **Fzf:** Command-line fuzzy finder  
- **Duf:** Disk usage utility  
- **Eza:** Modern replacement for `ls`  
- **Ugrep:** Enhanced grep utility  
- **Lazydocker & Lazygit:** Simple terminal UI for Docker and Git  

### Flatpak Applications (selected)
- **Spotify**  
- **Firefox**  
- **Thunderbird**  
- **DBeaver**  
- **VLC Media Player**  
- **ONLYOFFICE**  
- **Telegram Desktop**  
- **Flatseal (permissions manager)**  

### Virtualization & Containers
- **Docker**  
- **VirtualBox**  

### Fonts
- **Nerd Fonts:** Roboto Mono, JetBrains Mono, and FiraCode patched with glyphs for development  

---

## Usage

Clone this repository and execute the scripts in the preferred order to configure your Fedora Workstation environment.  
Each script can be run independently or combined into a master setup script.

```bash
./dotfiles.sh
./libraries.sh
./rpm-fusion.sh
./nerdfonts.sh
./flatpak.sh
./set-gnome-extensions.sh
./set-gnome-hotkeys.sh
./set-gnome-preferences.sh
./set-openssl-legacy.sh
./tpm2.sh
````

---

## Screenshots

![Screenshot 1](https://github.com/user-attachments/assets/4ec280bd-3768-42fd-8e19-58d44a72ecfd)

---

![Screenshot 2](https://github.com/user-attachments/assets/086bdce0-d134-4206-9449-a566c187e9f2)

---

![Screenshot 3](https://github.com/user-attachments/assets/9125e02a-650e-45ff-9084-f6b79f6e93c7)

---

![Screenshot 4](https://github.com/user-attachments/assets/5ec8daa0-e1b2-4867-8616-7431bb64c8e1)

---

## Contributing

Contributions, issues, and feature requests are welcome.
Please open an issue or submit a pull request on GitHub.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

**Author:** Fabio Scotto di Santolo
