#!/bin/bash

pushd "$(dirname "$0")" || exit

curl "https://chromium.googlesource.com/apps/libapps/+/HEAD/hterm/LICENSE?format=TEXT" | base64 -d > LICENSE
curl "https://chromium.googlesource.com/apps/libapps/+/HEAD/hterm/etc/hterm-notify.sh?format=TEXT" | base64 -d > hterm-notify.sh
curl "https://chromium.googlesource.com/apps/libapps/+/HEAD/hterm/etc/osc52.sh?format=TEXT" | base64 -d > osc52.sh

popd || exit
