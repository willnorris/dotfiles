#!/bin/bash

. "${HOME}/.config/shell/_xdg_base.sh"

ln -sn "${XDG_CONFIG_HOME}/vim" "${HOME}/.vim" 2>/dev/null

mkdir -p "${XDG_CONFIG_HOME}/vim/bundle"
if [ ! -f "${XDG_CONFIG_HOME}/vim/autoload/plug.vim" ]; then
  curl -sfLo "${XDG_CONFIG_HOME}/vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# TODO: investigate why running this as part of rcm hook causes problems with
# the environment such that no other hooks are run.
#vim +PlugInstall +qall >/dev/null
