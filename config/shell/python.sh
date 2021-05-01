[ -z "$PS1" ] && return # interactive only

if [ -z "$PYENV_ROOT" ] && [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
fi

if [ -n "$PYENV_ROOT" ]; then
  PATH="$PYENV_ROOT/bin:$PATH"
fi

if command -v pyenv >/dev/null; then
  eval "$(pyenv init -)"
fi
