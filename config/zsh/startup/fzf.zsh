if (( $+commands[fzf] )); then
  if [ -f "$FZF_HOME/shell/completion.zsh" ]; then
    source "$FZF_HOME/shell/completion.zsh"
  elif [ -f "/usr/share/fzf/completion.zsh" ]; then
    source "/usr/share/fzf/completion.zsh"
  elif [ -f "/usr/share/doc/fzf/examples/completion.zsh" ]; then
    source "/usr/share/doc/fzf/examples/completion.zsh"
  fi

  bindkey -v
  if [ -f "$FZF_HOME/shell/key-bindings.zsh" ]; then
    source "$FZF_HOME/shell/key-bindings.zsh"
  elif [ -f "/usr/share/fzf/key-bindings.zsh" ]; then
    source "/usr/share/fzf/key-bindings.zsh"
  elif [ -f "/usr/share/doc/fzf/examples/key-bindings.zsh" ]; then
    source "/usr/share/doc/fzf/examples/key-bindings.zsh"
  fi
fi
