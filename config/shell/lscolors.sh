#!/bin/sh

# Setup ls colors

[ -z "$PS1" ] && return # interactive only

if [ -r "$XDG_CONFIG_HOME/shell/dircolors" ]; then
  if has udircolors; then
    eval "$(udircolors ~/.config/shell/dircolors)"
  elif has gdircolors; then
    eval "$(gdircolors ~/.config/shell/dircolors)"
  elif has dircolors; then
    eval "$(dircolors ~/.config/shell/dircolors)"
  fi
fi

# The leading space in all of these aliases prevents them from polluting the shell history.
if has gls; then
  alias ls=" gls --color=auto -F -N"
elif ls --color=auto >/dev/null 2>&1; then
  alias ls=" ls --color=auto -FG"
else
  # Incase we're using BSD ls with color support.
  export CLICOLOR=1
  export LSCOLORS="Gxfxcxdxbxegedabagacad"
  alias ls=" ls -F"
fi
