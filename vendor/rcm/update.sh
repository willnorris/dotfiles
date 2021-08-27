#!/bin/sh

TMP=$(mktemp -d --suffix=.rcm)
RCM="${HOME}/.dotfiles/rcm"

git clone https://github.com/thoughtbot/rcm ${TMP} || exit
cd ${TMP}

./autogen.sh && ./configure --prefix ${RCM} || exit
make && make install || exit

find "${RCM}/share/man" -type f | grep -v ".gz" | xargs gzip -f
