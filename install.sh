#!/bin/bash

# for now, limit this install script to Codespaces so that I can make certain
# assumptions about the environment
if [[ `hostname` != "codespaces_"* ]]; then
  echo "this install script is currently only intended for GitHub Codespaces"
  exit 1
fi

# move ~/dotfiles to ~/.dotfiles
if [ -d "${HOME}/dotfiles" ] && [ ! -d "${HOME}/.dotfiles" ]; then
  mv "${HOME}/dotfiles" "${HOME}/.dotfiles"
fi

# setup rcm config if not present
if [ ! -f "${HOME}/.rcrc" ]; then
  cp "${HOME}/.dotfiles/rcrc.example" "${HOME}/.rcrc"
fi

# run rcm (force install dotfiles)
PATH="${HOME}/.dotfiles/rcm/bin:${PATH}" rcup -f
