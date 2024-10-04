#!/usr/bin/env bash

function package_status {
  local pkg="$1"
  repoquery -a --installed | grep "$pkg" >/dev/null
  echo "$?"
}

function fedora_version {
  local version
  local available_versions=("40" "41")
  for v in "${available_versions[@]}"; do
    if [[ "$(grep -w "VERSION" /etc/os-release)" == *$v* ]]; then
      version="$v"
    fi
  done
  echo "$version"
}
