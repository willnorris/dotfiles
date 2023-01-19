#!/usr/bin/env bash

. "${HOME}/.config/shell/_base.sh"

ln -s "${XDG_CONFIG_HOME}/tmux/tmux.conf" "${HOME}/.tmux.conf" 2>/dev/null

# always return 0 status
true
