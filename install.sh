#!/bin/bash

# move ~/dotfiles to ~/.dotfiles
if [ -d "${HOME}/dotfiles" ] && [ ! -d "${HOME}/.dotfiles" ]; then
  mv "${HOME}/dotfiles" "${HOME}/.dotfiles"
fi

# setup rcm config if not present
if [ ! -f "${HOME}/.rcrc" ]; then
  cp "${HOME}/.dotfiles/rcrc.example" "${HOME}/.rcrc"
fi

if [[ `hostname` == "codespaces_"* ]]; then
  echo 'TAGS="codespaces"' >> ~/.rcrc
  # run rcm (force install dotfiles)
  PATH="${HOME}/.dotfiles/rcm/bin:${PATH}" rcup -f
else
  PATH="${HOME}/.dotfiles/rcm/bin:${PATH}" rcup
fi

if [ -f "${HOME}/.customize_environment" ]; then
  sudo ${HOME}/.customize_environment ${USER}
fi
