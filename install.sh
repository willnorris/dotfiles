#!/bin/sh

# move ~/dotfiles to ~/.dotfiles
if [ -d "${HOME}/dotfiles" ] && [ ! -d "${HOME}/.dotfiles" ]; then
  mv "${HOME}/dotfiles" "${HOME}/.dotfiles"
fi

# run the codespaces install script.  This should be set as the default install
# script for Codespaces, but that setting is probably loaded too late.
if [ "${USER}" = "codespace" ]; then
  source "${HOME}/.dotfiles/tag-codespaces/install.sh"
fi
