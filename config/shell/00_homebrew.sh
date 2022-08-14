#!/usr/bin/env bash

if [ -z "$HOMEBREW_HOME" ] && [ -d "/opt/homebrew" ]; then
  HOMEBREW_HOME="/opt/homebrew"
fi

if [ -n "$HOMEBREW_HOME" ]; then
  pathadd "$HOMEBREW_HOME/bin"
fi
