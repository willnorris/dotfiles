# vim: ft=zsh

if [[ -d "$HOMEBREW_HOME/opt/fzf" ]]; then
  export FZF_HOME="$HOMEBREW_HOME/opt/fzf"
fi

if (( ! $+FZF_HOME )) && [[ -d $HOME/.fzf ]]; then
  export FZF_HOME=$HOME/.fzf
fi

if (( $+FZF_HOME )); then
  path=($FZF_HOME/bin $path)
fi
