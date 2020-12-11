#!/bin/sh

# move ~/dotfiles to ~/.dotfiles
if [ -d "${HOME}/dotfiles" ] && [ ! -d "${HOME}/.dotfiles" ]; then
  mv "${HOME}/dotfiles" "${HOME}/.dotfiles"
fi

# run the codespaces install script.
if [ "$CODESPACES" = "true" ]; then
  . "${HOME}/.dotfiles/tag-codespaces/install.sh"
fi
