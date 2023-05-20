#!/bin/bash

pushd "$(dirname "$0")" || exit

curl -OL "https://raw.githubusercontent.com/rupa/z/master/z.sh"
curl -OL "https://raw.githubusercontent.com/rupa/z/master/z.1"

popd || exit
