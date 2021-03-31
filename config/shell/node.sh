[ -z "$PS1" ] && return # interactive only

if [ -z "$NODENV_ROOT" ] && [ -d $HOME/.nodenv ]; then
  export NODENV_ROOT=$HOME/.nodenv
fi

if [ -n "$NODENV_ROOT" ]; then
  PATH="$NODENV_ROOT/bin:$PATH"
fi

if command -v nodenv >/dev/null; then
  eval "$(nodenv init -)"
fi
