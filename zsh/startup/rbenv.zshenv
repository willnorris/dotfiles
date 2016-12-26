# vim: ft=zsh

if (( ! $+RBENV_ROOT )) && [[ -d $HOME/.rbenv ]]; then
  export RBENV_ROOT=$HOME/.rbenv
fi
