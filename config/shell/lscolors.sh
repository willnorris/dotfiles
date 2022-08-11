#!/usr/bin/env bash

# Setup ls colors

[ -z "$PS1" ] && return # interactive only

if [ -r "$XDG_CONFIG_HOME/personal/dircolors" ]; then
  if command -v udircolors >/dev/null; then
    eval "$(udircolors ~/.config/personal/dircolors)"
  elif command -v gdircolors >/dev/null; then
    eval "$(gdircolors ~/.config/personal/dircolors)"
  elif command -v dircolors >/dev/null; then
    eval "$(dircolors ~/.config/personal/dircolors)"
  fi
fi

if command -v gls >/dev/null; then
  alias ls=" gls --color=auto -F -N"
elif ls --color=auto >/dev/null 2>/dev/null; then
  alias ls=" ls --color=auto -F"
else
  # Incase we're using BSD ls with color support.
  export CLICOLOR=1
  export LSCOLORS="Gxfxcxdxbxegedabagacad"
  alias ls=" ls -F"
fi
