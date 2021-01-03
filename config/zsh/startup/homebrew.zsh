# vim: ft=zsh

if [[ -f $HOMEBREW_HOME/opt/grc/etc/grc.bashrc ]]; then
  source $HOMEBREW_HOME/opt/grc/etc/grc.bashrc
fi

if [[ -d "$HOMEBREW_HOME/share/zsh/site-functions" ]]; then
  fpath+=$HOMEBREW_HOME/share/zsh/site-functions
fi

if [[ -d "$HOMEBREW_HOME/share/zsh-completions" ]]; then
  fpath+=$HOMEBREW_HOME/share/zsh-completions
fi
