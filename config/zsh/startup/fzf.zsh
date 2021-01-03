if (( $+commands[fzf] )); then
  if [ -f "$FZF_HOME/shell/completion.zsh" ]; then
    source "$FZF_HOME/shell/completion.zsh"
  fi

  bindkey -v
  if [ -f "$FZF_HOME/shell/key-bindings.zsh" ]; then
    source "$FZF_HOME/shell/key-bindings.zsh"
  fi
fi
