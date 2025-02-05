#!/bin/sh

[ -z "$PS1" ] && return # interactive only

[ -n "${SSH_AUTH_SOCK}" ] && return # already set

# prefer secretive if installed (https://github.com/maxgoedjen/secretive)
if [ -r "${HOME}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh" ]; then
  export SSH_AUTH_SOCK="${HOME}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh"
  return
fi

# then try keychain (https://www.funtoo.org/Keychain)
if has keychain; then
  if [ -f "$HOME/.ssh/id_ed25519" ]; then
    mkdir -p "${XDG_RUNTIME_DIR}/keychain"
    eval "$(keychain --dir "${XDG_RUNTIME_DIR}/keychain" --absolute --eval --quiet --agents ssh id_ed25519)"
  fi
fi
