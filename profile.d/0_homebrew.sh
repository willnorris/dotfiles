if [ -z "$HOMEBREW_HOME" ]; then
  if [ -d /usr/local/homebrew ]; then
    export HOMEBREW_HOME=/usr/local/homebrew
  fi
fi

if [ -n "$HOMEBREW_HOME" ]; then
  PATH="$HOMEBREW_HOME/bin:$PATH"
fi
