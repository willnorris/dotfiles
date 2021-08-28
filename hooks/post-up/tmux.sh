#!/bin/zsh

. "${HOME}/.config/shell/_xdg_base.sh"

ln -s "${XDG_CONFIG_HOME}/tmux/tmux.conf" "${HOME}/.tmux.conf" 2>/dev/null
