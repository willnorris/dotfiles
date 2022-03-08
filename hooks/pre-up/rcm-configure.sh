#!/bin/bash

set -eu

. "../../config/shell/_xdg_base.sh"

pushd "$(dirname "$0")" > /dev/null
cd ../..
dotfiles_dir="$(pwd)"
popd > /dev/null

: "${RCRC:="${XDG_CONFIG_HOME}/rcm/rcrc"}"
if [ ! -f "${RCRC}" ]; then
  echo "INFO: Installing default ${RCRC} file" 1>&2
  mkdir -p $(dirname ${RCRC})
  cp "${dotfiles_dir}/rcrc.example" "${RCRC}"
fi
