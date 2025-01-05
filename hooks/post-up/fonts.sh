#!/usr/bin/env bash
# Download and install Cascadia Mono NF Regular

VERSION="2407.24"
FILE="CascadiaMonoNF-Regular.otf"

. "${HOME}/.config/shell/_base.sh"

# On Linux, check if the font is already installed
fc-list "${FILE%.*}" &>/dev/null && exit

if [ "$(uname)" = "Linux" ]; then
  FONTS="${HOME}/.local/share/fonts"
elif [ "$(uname)" = "Darwin" ]; then
  FONTS="${HOME}/Library/Fonts"
fi

if [ ! -f "${FONTS}/${FILE}" ] && has_network; then
  mkdir -p "${FONTS}"
  TMP=$(mktemp -d)
  pushd "${TMP}" || exit
  curl -OLs "https://github.com/microsoft/cascadia-code/releases/download/v${VERSION}/CascadiaCode-${VERSION}.zip"
  unzip -qo "CascadiaCode-${VERSION}.zip"
  mv "./otf/static/${FILE}" "${FONTS}"
  popd || exit
  rm -rf "${TMP}"
fi
