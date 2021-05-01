[ -z "$PS1" ] && return # interactive only

if [ -z "$RBENV_ROOT" ] && [ -d "$HOME/.rbenv" ]; then
  export RBENV_ROOT="$HOME/.rbenv"
fi

if [ -n "$RBENV_ROOT" ]; then
  PATH="$RBENV_ROOT/shims:$RBENV_ROOT/bin:$PATH"
fi

if command -v rbenv >/dev/null; then
  # TODO: is this really zsh specific?
  eval "$(rbenv init - --no-rehash zsh)"
fi
