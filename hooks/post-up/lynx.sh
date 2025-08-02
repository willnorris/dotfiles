#!/usr/bin/env bash

. "${HOME}/.config/shell/_base.sh"

link_file "${XDG_CONFIG_HOME}/lynx/lynx.lss" "${HOME}/.lynx.lss"
link_file "${XDG_CONFIG_HOME}/lynx/lynxrc" "${HOME}/.lynxrc"
