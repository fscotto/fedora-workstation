#!/usr/bin/env bash

function package_status {
  local pkg="$1"
  repoquery -a --installed | grep "$pkg" >/dev/null
  echo "$?"
}
