#!/bin/sh

[ -z "$PS1" ] && return # interactive only

if [ -r /dev/tty ]; then
  # disable tty stop and start
  stty stop undef start undef </dev/tty
fi
