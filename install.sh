#!/bin/sh

# link installed dotfiles location to ~/.dotfiles
DOTFILE_DIR=$(dirname $(realpath $0))
if [ -d "${DOTFILE_DIR}" ] && [ ! -d "${HOME}/.dotfiles" ]; then
  ln -s "${DOTFILE_DIR}" "${HOME}/.dotfiles"
fi

# run the codespaces install script.
if [ "$CODESPACES" = "true" ]; then
  . "${HOME}/.dotfiles/tag-codespaces/install.sh"
fi
