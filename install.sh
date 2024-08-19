#!/bin/sh

# if dotfiles have been installed anywhere other than ~/.dotfiles,
# add a link there. This is mainly for GitHub codespaces.
DOTFILE_DIR="$(dirname "$(realpath "$0")")"
if [ -d "${DOTFILE_DIR}" ] && [ ! -d "${HOME}/.dotfiles" ]; then
  ln -s "${DOTFILE_DIR}" "${HOME}/.dotfiles"
fi

# If we're running in codespaces, run the install script,
# otherwise just run rcup.
if [ "$CODESPACES" = "true" ]; then
  . "${HOME}/.dotfiles/tag-codespaces/install.sh"
else
  PATH="${HOME}/.dotfiles/local/bin:${PATH}" rcup
fi
