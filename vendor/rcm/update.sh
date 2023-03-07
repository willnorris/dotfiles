#!/bin/sh

# build dependencies:
#   apt install autotools-dev automake
#   gem install mustache

set -x

TMP=$(mktemp -d)
RCM="${HOME}/.dotfiles/vendor/rcm"

git clone https://github.com/thoughtbot/rcm "${TMP}" || exit
cd "${TMP}" || exit

./autogen.sh && ./configure --prefix "${RCM}" || exit
make && make install || exit

find "${RCM}/share/man" -type f | grep -v ".gz" | xargs gzip -f
