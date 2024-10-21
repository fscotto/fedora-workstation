#!/usr/bin/env bash

echo -e "Setting my GNOME Preferences\n"

status=$(package_status "papirus-icon-theme-dark")
if [ "$status" -ne 0 ]; then
  sudo dnf install --assumeyes papirus-icon-theme-dark
else
  echo -e "\nPapiru icons already installed\n"
fi

# Creating folders in app menu
gsettings set org.gnome.desktop.app-folders folder-children "['Utilities', 'YaST', 'Pardus', 'ebe9c514-6000-498c-b613-cdc4b223d5e2', '02123af2-796e-4d92-90cb-58ec32548cde', 'ffdae5ed-cad3-4f54-8493-483f62ce7c84']"

# Set folder "Administration Tools" (aka 02123af2-796e-4d92-90cb-58ec32548cde)
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/02123af2-796e-4d92-90cb-58ec32548cde/ apps "['org.gnome.Software.desktop', 'io.github.prateekmedia.appimagepool.desktop', 'org.gnome.Settings.desktop', 'com.mattjakeman.ExtensionManager.desktop', 'org.gnome.tweaks.desktop', 'ca.desrt.dconf-editor.desktop', 'com.github.tchx84.Flatseal.desktop', 'io.github.flattool.Warehouse.desktop', 'org.gnome.DiskUtility.desktop', 'org.gnome.Logs.desktop', 'io.github.pwr_solaar.solaar.desktop', 'org.gnome.SystemMonitor.desktop', 'io.missioncenter.MissionCenter.desktop', 'org.fedoraproject.FirewallConfig.desktop', 'org.gnome.seahorse.Application.desktop']"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/02123af2-796e-4d92-90cb-58ec32548cde/ name 'Administration Tools'

# Set folder "Office" (aka ebe9c514-6000-498c-b613-cdc4b223d5e2)
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/ebe9c514-6000-498c-b613-cdc4b223d5e2/ apps "['io.github.troyeguo.koodo-reader.desktop', 'net.codeindustry.MasterPDFEditor.desktop', 'org.onlyoffice.desktopeditors.desktop', 'libreoffice-writer.desktop', 'libreoffice-calc.desktop', 'libreoffice-impress.desktop', 'com.github.xournalpp.xournalpp.desktop']"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/ebe9c514-6000-498c-b613-cdc4b223d5e2/ name 'Office'

# Set folder Utilities
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ apps "['org.gnome.baobab.desktop', 'org.gnome.Evince.desktop', 'org.gnome.Loupe.desktop', 'org.fedoraproject.MediaWriter.desktop', 'org.raspberrypi.rpi-imager.desktop', 'org.gnome.Characters.desktop', 'org.gnome.font-viewer.desktop', 'simple-scan.desktop', 'nl.hjdskes.gcolor3.desktop', 'nvim.desktop', 'fish.desktop', 'htop.desktop', 'btop.desktop', 'yelp.desktop', 'org.gnome.Tour.desktop', 'org.freedesktop.GnomeAbrt.desktop']"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ categories "['X-GNOME-Utilities']"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ excluded-apps "['org.gnome.Connections.desktop', 'org.gnome.DiskUtility.desktop', 'org.gnome.tweaks.desktop', 'org.gnome.Logs.desktop']"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ name 'X-GNOME-Utilities.directory'
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ translate true

# Other configs
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us+alt-intl'), ('xkb', 'it')]"
gsettings set org.gnome.desktop.input-sources current 0
gsettings set org.gnome.desktop.input-sources mru-sources "[('xkb', 'us+alt-intl'), ('xkb', 'it')]"
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface enable-animations true
gsettings set org.gnome.desktop.interface enable-hot-corners true
gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus'
gsettings set org.gnome.desktop.interface monospace-font-name 'FiraCode Nerd Font Mono 12'
gsettings set org.gnome.desktop.notifications application-children "['org-gnome-terminal', 'gnome-power-panel', 'org-telegram-desktop', 'org-gnome-nautilus', 'org-mozilla-firefox', 'jetbrains-toolbox', 'jetbrains-idea-71be2013-d721-4b24-a8a5-627fff40cb97', 'org-gnome-software', 'org-mozilla-thunderbird', 'org-gnome-boxes', 'gnome-printers-panel', 'org-gnome-evolution-alarm-notify', 'io-github-prateekmedia-appimagepool', 'com-spotify-client', 'com-vscodium-codium', 'com-mattjakeman-extensionmanager', 'org-gnome-calendar', 'io-dbeaver-dbeavercommunity', 'org-gnome-texteditor', 'org-gnome-settings', 'me-iepure-devtoolbox', 'com-github-krtirtho-spotube', 'com-jetbrains-intellij-idea-ultimate', 'org-gnome-meld', 'ca-desrt-dconf-editor', 'org-freedesktop-problems-applet', 'fish', 'intellij-idea-ultimate', 'org-gnome-evince', 'org-gnome-shell-portalhelper', 'com-github-xournalpp-xournalpp', 'fr-handbrake-ghb', 'io-github-troyeguo-koodo-reader', 'pycharm-community', 'com-usebruno-bruno']"
gsettings set org.gnome.desktop.privacy old-files-age 7
gsettings set org.gnome.desktop.privacy recent-files-max-age 30
gsettings set org.gnome.desktop.privacy remove-old-temp-files true
gsettings set org.gnome.desktop.privacy remove-old-trash-files true
gsettings set org.gnome.desktop.privacy report-technical-problems false
gsettings set org.gnome.desktop.screensaver primary-color '#51a2da'
gsettings set org.gnome.desktop.screensaver secondary-color '#294172'
gsettings set org.gnome.desktop.search-providers enabled "['org.gnome.Contacts.desktop', 'org.gnome.Calculator.desktop', 'org.gnome.Calendar.desktop', 'org.gnome.Characters.desktop', 'org.gnome.clocks.desktop', 'org.gnome.Boxes.desktop', 'org.gnome.Weather.desktop']"
gsettings set org.gnome.desktop.search-providers sort-order "['org.gnome.Documents.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Contacts.desktop', 'org.gnome.Calculator.desktop', 'org.gnome.Calendar.desktop', 'org.gnome.Boxes.desktop']"
gsettings set org.gnome.desktop.wm.preferences action-double-click-titlebar 'toggle-maximize'
gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'minimize'
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

# GNOME Shell conf
gsettings set org.gnome.shell.weather automatic-location true
gsettings set org.gnome.shell.weather locations "[<(uint32 2, <('Rome', 'LIRU', true, [(0.73216562121162132, 0.21816615649929119)], [(0.73129295658562399, 0.21787526247286132)])>)>]"
gsettings set org.gnome.shell app-picker-layout "[{'02123af2-796e-4d92-90cb-58ec32548cde': <{'position': <0>}>, 'Utilities': <{'position': <1>}>, 'ebe9c514-6000-498c-b613-cdc4b223d5e2': <{'position': <2>}>, 'com.google.Chrome.desktop': <{'position': <3>}>, 'org.filezillaproject.Filezilla.desktop': <{'position': <4>}>, 'uk.org.greenend.chiark.sgtatham.putty.desktop': <{'position': <5>}>, 'org.freefilesync.FreeFileSync.desktop': <{'position': <6>}>, 'org.freefilesync.FreeFileSync.RealTimeSync.desktop': <{'position': <7>}>, 'virtualbox.desktop': <{'position': <8>}>, 'org.gnome.Boxes.desktop': <{'position': <9>}>, 'org.gnome.Contacts.desktop': <{'position': <10>}>, 'org.gnome.Weather.desktop': <{'position': <11>}>, 'org.gnome.clocks.desktop': <{'position': <12>}>, 'org.gnome.Maps.desktop': <{'position': <13>}>, 'org.gnome.Calendar.desktop': <{'position': <14>}>, 'org.gnome.Snapshot.desktop': <{'position': <15>}>, 'org.gnome.Calculator.desktop': <{'position': <16>}>, 'org.gnome.TextEditor.desktop': <{'position': <17>}>, 'io.github.Qalculate.desktop': <{'position': <18>}>, 'fr.handbrake.ghb.desktop': <{'position': <19>}>, 'org.videolan.VLC.desktop': <{'position': <20>}>, 'pycharm-community.desktop': <{'position': <21>}>, 'io.dbeaver.DBeaverCommunity.desktop': <{'position': <22>}>, 'com.usebruno.Bruno.desktop': <{'position': <23>}>}]"
gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'org.mozilla.firefox.desktop', 'org.mozilla.Thunderbird.desktop', 'org.telegram.desktop.desktop', 'com.spotify.Client.desktop', 'code.desktop', 'intellij-idea-ultimate.desktop', 'postman.desktop', 'me.iepure.devtoolbox.desktop', 'kitty.desktop']"
gsettings set org.gnome.shell last-selected-power-profile 'performance'
#gsettings set org.gnome.shell welcome-dialog-last-shown-version '46.0'

# Mutter conf
gsettings set org.gnome.mutter attach-modal-dialogs true
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.mutter dynamic-workspaces true
gsettings set org.gnome.mutter edge-tiling true
gsettings set org.gnome.mutter overlay-key 'Super_L'
gsettings set org.gnome.mutter workspaces-only-on-primary true

# Nautilus conf
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
gsettings set org.gnome.nautilus.preferences migrated-gtk-settings true
gsettings set org.gnome.nautilus.preferences search-filter-time-type 'last_modified'
gsettings set org.gnome.nautilus.preferences show-create-link true
gsettings set org.gnome.nautilus.preferences show-delete-permanently true
gsettings set org.gnome.nautilus.list-view default-column-order "['name', 'size', 'type', 'owner', 'group', 'permissions', 'date_modified', 'date_accessed', 'date_created', 'recency', 'detailed_type']"
gsettings set org.gnome.nautilus.list-view default-visible-columns "['name', 'size', 'type', 'owner', 'group', 'permissions', 'date_modified']"
gsettings set org.gnome.nautilus.list-view default-zoom-level 'large'
gsettings set org.gtk.Settings.FileChooser sort-directories-first true

# Background conf
cp "$SCRIPT_DIR"/data/background.jpg "$HOME"/.config/background
gsettings set org.gnome.desktop.background picture-uri 'file:///home/fscotto/.config/background'
gsettings set org.gnome.desktop.background picture-uri-dark 'file:///home/fscotto/.config/background'
gsettings set org.gnome.desktop.background picture-options 'zoom'

# Install file templates
mkdir -p "$HOME"/Templates
unzip "$SCRIPT_DIR"/data/templates.zip -d "$HOME"/Templates

# Configuration Nautilus extensions
mkdir -p "$HOME"/.local/share/nautilus-python/extensions

# Copy path extension
cd /tmp || return
if [ ! -d /tmp/nautilus-copypath ]; then
  git clone https://github.com/ronen25/nautilus-copypath
  cp /tmp/nautilus-copypath/nautilus-copypath.py ~/.local/share/nautilus-python/extensions/
  rm -rf /tmp/nautilus-copypath
fi

# Open any terminal extension
if [ ! -d /tmp/nautilus-open-any-terminal ]; then
  git clone https://github.com/Stunkymonkey/nautilus-open-any-terminal.git
  cd /tmp/nautilus-open-any-terminal || exit
  make
  sudo make install-nautilus schema
  sudo glib-compile-schemas /usr/share/glib-2.0/schemas
  rm -rf /tmp/nautilus-open-any-terminal
fi

gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal kitty
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal new-tab true

cd "$SCRIPT_DIR" || exit
