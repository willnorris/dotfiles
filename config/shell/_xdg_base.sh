#!/usr/bin/env bash

# variables for default XDG user directories
export XDG_CONFIG_HOME XDG_CACHE_HOME XDG_DATA_HOME XDG_RUNTIME_DIR

: "${XDG_CONFIG_HOME:="${HOME}/.config"}"
: "${XDG_CACHE_HOME:="${HOME}/.cache"}"
: "${XDG_DATA_HOME:="${HOME}/.local/share"}"
: "${XDG_RUNTIME_DIR:="${HOME}/.local/run"}"
