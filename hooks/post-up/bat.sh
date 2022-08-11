#!/usr/bin/env bash

if command -v bat >/dev/null; then
  bat cache --build
fi
