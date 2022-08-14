#!/usr/bin/env bash

# variables for default XDG user directories
export XDG_CONFIG_HOME XDG_CACHE_HOME XDG_DATA_HOME XDG_RUNTIME_DIR

: "${XDG_CONFIG_HOME:="${HOME}/.config"}"
: "${XDG_CACHE_HOME:="${HOME}/.cache"}"
: "${XDG_DATA_HOME:="${HOME}/.local/share"}"
: "${XDG_RUNTIME_DIR:="${HOME}/.local/run"}"

# Return exit code 0 if the specified command exists.
has() {
  type "$1" &>/dev/null
}

# Add a new path to the PATH environment variable if it is a directory and is
# not already in PATH.
pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1${PATH:+":$PATH"}"
    fi
}
