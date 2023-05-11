#!/usr/bin/env bash

set -eu

. "../../config/shell/_base.sh"

: "${RCRC:="${XDG_CONFIG_HOME}/rcm/rcrc"}"
if [ ! -f "${RCRC}" ]; then
  echo "INFO: Installing default ${RCRC} file" 1>&2
  mkdir -p "$(dirname "${RCRC}")"
  cp "../../config/rcm/rcrc.example" "${RCRC}"
fi
