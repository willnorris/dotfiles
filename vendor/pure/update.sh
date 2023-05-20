#!/bin/bash

pushd "$(dirname "$0")" || exit

curl -o LICENSE "https://raw.githubusercontent.com/sindresorhus/pure/main/license"
curl -OL "https://raw.githubusercontent.com/sindresorhus/pure/main/async.zsh"
curl -OL "https://raw.githubusercontent.com/sindresorhus/pure/main/pure.zsh"

popd || exit
