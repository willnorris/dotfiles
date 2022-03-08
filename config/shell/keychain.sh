[ -z "$PS1" ] && return # interactive only

if command -v keychain >/dev/null; then
  if [ -f "$HOME/.ssh/id_rsa" ]; then
    mkdir -p "${XDG_RUNTIME_DIR}/keychain"
    eval "$(keychain --dir "${XDG_RUNTIME_DIR}/keychain" --absolute --eval --quiet --agents ssh id_rsa)"
  fi
fi
