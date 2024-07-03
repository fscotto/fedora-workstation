#!/usr/bin/env bash

rm scripts/gnome-settings.sh >/dev/null
tee -a scripts/gnome-settings.sh << EOF
#!/usr/bin/env bash

EOF

for schema in $(gsettings list-schemas | sort)
do
    for key in $(gsettings list-keys $schema | sort)
    do
        value="$(gsettings range $schema $key | tr "\n" " ")"
        echo "gsettings set $schema $key $value" >> scripts/gnome-settings.sh
    done
done
