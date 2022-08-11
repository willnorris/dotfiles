#!/usr/bin/env bash

. "${HOME}/.config/shell/_xdg_base.sh"

if [ ! -d "${XDG_DATA_HOME}/asdf" ]; then
  git clone https://github.com/asdf-vm/asdf.git "${XDG_DATA_HOME}/asdf"
fi
