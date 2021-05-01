[ -z "$PS1" ] && return # interactive only

if command -v keychain >/dev/null; then
  if [ -f "$HOME/.ssh/id_rsa" ]; then
    eval "$(keychain --eval --quiet --agents ssh id_rsa)"
  fi
fi
