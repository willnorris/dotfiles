#!/bin/sh
# ~/.config/profile contains common configuration for bourne compatible shells.

. /etc/profile

# User Information
: "${EMAIL:="will@willnorris.com"}"

. "${HOME}/.config/shell/_base.sh"

# include ~/.local/bin early before shell/* so mise is available.
pathadd "$HOME/.local/bin"

if [ -d "${XDG_CONFIG_HOME}/shell" ]; then
  for i in "${XDG_CONFIG_HOME}/shell"/*.sh; do
    if [ -r "$i" ]; then
      . "$i"
    fi
  done
  unset i
fi

# include ~/.local/bin again late to give precedence.
if [ -d "$HOME/.local/bin" ]; then
  PATH="${HOME}/.local/bin:${PATH}"
fi
