#!/usr/bin/env bash

. "${HOME}/.config/shell/_base.sh"

if has tic; then
  tic -x "${HOME}/.terminfo/tmux-256color.terminfo"
  tic -x "${HOME}/.terminfo/xterm-256color.terminfo"
fi

