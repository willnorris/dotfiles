#!/usr/bin/env bash
# Download and install Cascadia Code Nerd Font Mono

. "${HOME}/.config/shell/_base.sh"

if [ "$(uname)" = "Linux" ]; then
  FONTS="${HOME}/.local/share/fonts"
elif [ "$(uname)" = "Darwin" ]; then
  FONTS="${HOME}/Library/Fonts"
fi

FILE="CaskaydiaCoveNerdFontMono-Regular.ttf"
if [ ! -f "${FONTS}/${FILE}" ] && $(has_network); then
  mkdir -p "${FONTS}"
  TMP=$(mktemp -d)
  pushd "${TMP}" || exit
  curl -OL "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CascadiaCode.tar.xz"
  tar -xJf CascadiaCode.tar.xz
  mv "${FILE}" "${FONTS}"
  popd || exit
  rm -rf "${TMP}"
fi
