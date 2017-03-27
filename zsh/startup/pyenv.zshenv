# vim: ft=zsh

if (( ! $+PYENV_ROOT )) && [[ -d $HOME/.pyenv ]]; then
  export PYENV_ROOT=$HOME/.pyenv
fi
