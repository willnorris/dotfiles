# vim: ft=zsh

if (( $+PYENV_ROOT )); then
  path=($PYENV_ROOT/bin $path)
fi

if (( $+commands[pyenv] )); then
  eval "$(pyenv init -)"
fi
