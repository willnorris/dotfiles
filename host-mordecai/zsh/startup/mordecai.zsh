# vim: ft=zsh

autoload -U colors && colors
PROMPT_COLOR="%{${fg[blue]}%}"

if (( $+commands[rbenv] )); then
  eval "$(rbenv init - --no-rehash zsh)"
fi

if [[ -f $HOMEBREW_HOME/opt/grc/etc/grc.bashrc ]]; then
  source $HOMEBREW_HOME/opt/grc/etc/grc.bashrc
fi

if [[ -n "$HOMEBREW_HOME" ]]; then
  fpath+=$HOMEBREW_HOME/share/zsh-completions
fi
