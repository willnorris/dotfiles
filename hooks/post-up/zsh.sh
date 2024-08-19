#!/usr/bin/env bash

. "${HOME}/.config/shell/_base.sh"

ln -s zshenv "${XDG_CONFIG_HOME}/zsh/.zshenv" 2>/dev/null
ln -s zprofile "${XDG_CONFIG_HOME}/zsh/.zprofile" 2>/dev/null
ln -s zshrc "${XDG_CONFIG_HOME}/zsh/.zshrc" 2>/dev/null
ln -s "${XDG_CONFIG_HOME}/zsh/zshenv" "${HOME}/.zshenv" 2>/dev/null

mkdir -p "${XDG_CONFIG_HOME}/zsh/bundle"
if [ ! -d "${XDG_CONFIG_HOME}/zsh/bundle/zsh-syntax-highlighting" ] && $(has_network); then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "${XDG_CONFIG_HOME}/zsh/bundle/zsh-syntax-highlighting"
fi

mkdir -p "${XDG_DATA_HOME}/zsh"
