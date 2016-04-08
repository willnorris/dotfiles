
if (( $+RBENV_ROOT )); then
  path=($RBENV_ROOT/bin $path)
fi

if (( $+commands[rbenv] )); then
  eval "$(rbenv init - --no-rehash zsh)"
fi
