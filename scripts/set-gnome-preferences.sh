#!/usr/bin/env bash

gsettings set org.gnome.shell.weather automatic-location true
gsettings set org.gnome.shell.weather locations [<(uint32 2, <('Rome', 'LIRU', true, [(0.73216562121162132, 0.21816615649929119)], [(0.73129295658562399, 0.21787526247286132)])>)>]
gsettings set org.gnome.shell app-picker-layout [{'02123af2-796e-4d92-90cb-58ec32548cde': <{'position': <0>}>, 'Utilities': <{'position': <1>}>, 'ebe9c514-6000-498c-b613-cdc4b223d5e2': <{'position': <2>}>, 'org.filezillaproject.Filezilla.desktop': <{'position': <3>}>, 'uk.org.greenend.chiark.sgtatham.putty.desktop': <{'position': <4>}>, 'org.gnome.Boxes.desktop': <{'position': <5>}>, 'org.gnome.Contacts.desktop': <{'position': <6>}>, 'org.gnome.Weather.desktop': <{'position': <7>}>, 'org.gnome.clocks.desktop': <{'position': <8>}>, 'org.gnome.Maps.desktop': <{'position': <9>}>, 'org.gnome.Calendar.desktop': <{'position': <10>}>, 'org.gnome.Snapshot.desktop': <{'position': <11>}>, 'org.gnome.Calculator.desktop': <{'position': <12>}>, 'org.gnome.TextEditor.desktop': <{'position': <13>}>, 'io.dbeaver.DBeaverCommunity.desktop': <{'position': <14>}>, 'org.videolan.VLC.desktop': <{'position': <15>}>}]
gsettings set org.gnome.shell favorite-apps ['org.gnome.Nautilus.desktop', 'org.mozilla.firefox.desktop', 'org.mozilla.Thunderbird.desktop', 'org.telegram.desktop.desktop', 'com.github.KRTirtho.Spotube.desktop', 'com.vscodium.codium.desktop', 'com.jetbrains.IntelliJ-IDEA-Ultimate.desktop', 'postman.desktop', 'io.podman_desktop.PodmanDesktop.desktop', 'org.gnome.meld.desktop', 'me.iepure.devtoolbox.desktop', 'org.gnome.Terminal.desktop']
gsettings set org.gnome.shell last-selected-power-profile 'performance'
gsettings set org.gnome.shell welcome-dialog-last-shown-version '46.0'
gsettings set org.gnome.desktop.input-sources sources [('xkb', 'us+alt-intl'), ('xkb', 'it')]
gsettings set org.gnome.desktop.input-sources current 0
gsettings set org.gnome.desktop.input-sources mru-sources [('xkb', 'us+alt-intl'), ('xkb', 'it')]
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface enable-animations true
gsettings set org.gnome.desktop.interface enable-hot-corners true
gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
gsettings set org.gnome.desktop.interface monospace-font-name 'RobotoMono Nerd Font 12'
gsettings set org.gnome.desktop.notifications application-children ['org-gnome-terminal', 'gnome-power-panel', 'org-telegram-desktop', 'org-gnome-nautilus', 'org-mozilla-firefox', 'jetbrains-toolbox', 'jetbrains-idea-71be2013-d721-4b24-a8a5-627fff40cb97', 'org-gnome-software', 'org-mozilla-thunderbird', 'org-gnome-boxes', 'gnome-printers-panel', 'org-gnome-evolution-alarm-notify', 'io-github-prateekmedia-appimagepool', 'com-spotify-client', 'com-vscodium-codium', 'com-mattjakeman-extensionmanager', 'org-gnome-calendar', 'io-dbeaver-dbeavercommunity', 'org-gnome-texteditor', 'org-gnome-settings', 'me-iepure-devtoolbox', 'com-github-krtirtho-spotube', 'com-jetbrains-intellij-idea-ultimate', 'org-gnome-meld', 'ca-desrt-dconf-editor']
gsettings set org.gnome.desktop.privacy old-files-age 7
gsettings set org.gnome.desktop.privacy recent-files-max-age 30
gsettings set org.gnome.desktop.privacy remove-old-temp-files true
gsettings set org.gnome.desktop.privacy remove-old-trash-files true
gsettings set org.gnome.desktop.privacy report-technical-problems false
gsettings set org.gnome.desktop.screensaver primary-color '#51a2da'
gsettings set org.gnome.desktop.screensaver secondary-color '#294172'
gsettings set org.gnome.desktop.search-providers enabled ['org.gnome.Contacts.desktop', 'org.gnome.Calculator.desktop', 'org.gnome.Calendar.desktop', 'org.gnome.Characters.desktop', 'org.gnome.clocks.desktop', 'org.gnome.Boxes.desktop', 'org.gnome.Weather.desktop']
gsettings set org.gnome.desktop.search-providers sort-order ['org.gnome.Documents.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Contacts.desktop', 'org.gnome.Calculator.desktop', 'org.gnome.Calendar.desktop', 'org.gnome.Boxes.desktop']
gsettings set org.gnome.desktop.wm.preferences action-double-click-titlebar 'toggle-maximize'
gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'minimize'
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.mutter attach-modal-dialogs true
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.mutter dynamic-workspaces true
gsettings set org.gnome.mutter edge-tiling true
gsettings set org.gnome.mutter overlay-key 'Super_L'
gsettings set org.gnome.mutter workspaces-only-on-primary true
gsettings set org.gnome.nautilus.list-view default-column-order ['name', 'size', 'type', 'owner', 'group', 'permissions', 'date_modified', 'date_accessed', 'date_created', 'recency', 'detailed_type']
gsettings set org.gnome.nautilus.list-view default-visible-columns ['name', 'size', 'type', 'owner', 'group', 'permissions', 'date_modified']
gsettings set org.gnome.nautilus.list-view default-zoom-level 'large'
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
gsettings set org.gnome.nautilus.preferences migrated-gtk-settings true
gsettings set org.gnome.nautilus.preferences search-filter-time-type 'last_modified'
gsettings set org.gnome.nautilus.preferences show-create-link true
gsettings set org.gnome.nautilus.preferences show-delete-permanently true