#!/usr/bin/env bash

. "${HOME}/.config/shell/_base.sh"

if has bat; then
  bat cache --build
fi
