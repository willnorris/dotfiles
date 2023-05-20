#!/bin/bash

pushd "$(dirname "$0")" || exit

curl -OL "https://raw.githubusercontent.com/eikenb/terminal-colors/master/terminal-colors"

popd || exit
