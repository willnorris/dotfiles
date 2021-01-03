if command -v fzf > /dev/null; then
  if [ -f "$FZF_HOME/shell/completion.bash" ]; then
    source "$FZF_HOME/shell/completion.bash"
  fi

  set -o vi
  if [ -f "$FZF_HOME/shell/key-bindings.bash" ]; then
    source "$FZF_HOME/shell/key-bindings.bash"
  fi
fi
