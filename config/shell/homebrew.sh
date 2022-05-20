if [ -z "$HOMEBREW_HOME" ] && [ -d "/opt/homebrew" ]; then
  HOMEBREW_HOME="/opt/homebrew"
fi

if [ -n "$HOMEBREW_HOME" ]; then
  PATH="$HOMEBREW_HOME/bin:$PATH"
fi
