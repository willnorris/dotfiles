#!/usr/bin/env bash

. "${HOME}/.config/shell/_base.sh"

if [ ! -d "${XDG_DATA_HOME}/asdf" ] && has_network; then
  git clone https://github.com/asdf-vm/asdf.git "${XDG_DATA_HOME}/asdf"
fi
