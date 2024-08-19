#!/bin/sh

# variables for default XDG user directories
export XDG_CACHE_HOME XDG_CONFIG_HOME XDG_DATA_HOME XDG_RUNTIME_DIR XDG_STATE_HOME

: "${XDG_CACHE_HOME:="${HOME}/.cache"}"
: "${XDG_CONFIG_HOME:="${HOME}/.config"}"
: "${XDG_DATA_HOME:="${HOME}/.local/share"}"
: "${XDG_RUNTIME_DIR:="${HOME}/.local/run"}"
: "${XDG_STATE_HOME:="${HOME}/.local/state"}"

if [ -r "${XDG_CONFIG_HOME}/user-dirs.dirs" ]; then
  . "${XDG_CONFIG_HOME}/user-dirs.dirs"
fi

# Return exit code 0 if the specified command exists.
has() {
  type "$1" >/dev/null 2>/dev/null
}

has_network() {
  ping -w1 -c1 8.8.8.8 2>/dev/null
}

# Add a new path to the PATH environment variable if it is a directory and is
# not already in PATH.
pathadd() {
  if [ -d "$1" ]; then
    case ":$PATH:" in
    *":$1:"*) : ;;
    *) PATH="$1:$PATH" ;;
    esac
  fi
}

# Create symlink to TARGET from LINK if it's not already linked.
link_file() {
  TARGET=$1
  LINK=$2

  if [ -r "${TARGET}" ]; then
    if [ ! -h "${LINK}" ] || [ "$(readlink "${LINK}")" != "${TARGET}" ]; then
      mkdir -p "$(dirname "${LINK}")"
      ln -s "${TARGET}" "${LINK}"
    fi
  fi
}
