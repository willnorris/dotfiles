#!/bin/bash

set -eu

pushd "$(dirname "$0")" > /dev/null
cd ../..
dotfiles_dir="$(pwd)"
popd > /dev/null

if [ ! -f "${HOME}/.rcrc" ]; then
  echo "INFO: Installing default ~/.rcrc file" 1>&2
  cp "${dotfiles_dir}/rcrc.example" "${HOME}/.rcrc"
fi
