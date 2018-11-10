# vim: ft=zsh

if (( $+HOMEBREW_HOME )); then
  path=($HOMEBREW_HOME/bin $HOMEBREW_HOME/sbin $path)
  manpath=($HOMEBREW_HOME/man $HOMEBREW_HOME/share/man $manpath)
fi
