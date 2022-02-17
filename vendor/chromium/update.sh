#!/bin/sh

curl "https://chromium.googlesource.com/apps/libapps/+/HEAD/hterm/etc/hterm-notify.sh?format=TEXT" | base64 -d > hterm-notify.sh
curl "https://chromium.googlesource.com/apps/libapps/+/HEAD/hterm/etc/osc52.sh?format=TEXT" | base64 -d > osc52.sh
curl "https://chromium.googlesource.com/apps/libapps/+/HEAD/hterm/etc/osc52.vim?format=TEXT" | base64 -d > osc52.vim
