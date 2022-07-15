if command -v fzf > /dev/null; then
  if [ -f "$FZF_HOME/shell/completion.bash" ]; then
    source "$FZF_HOME/shell/completion.bash"
  elif [ -f "/usr/share/doc/fzf/examples/completion.bash" ]; then
    source "/usr/share/doc/fzf/examples/completion.bash"
  fi

  set -o vi
  if [ -f "$FZF_HOME/shell/key-bindings.bash" ]; then
    source "$FZF_HOME/shell/key-bindings.bash"
  elif [ -f "/usr/share/doc/fzf/examples/key-bindings.bash" ]; then
    source "/usr/share/doc/fzf/examples/key-bindings.bash"
  fi
fi
