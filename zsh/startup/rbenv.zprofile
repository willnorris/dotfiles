# vim: ft=zsh

if (( $+RBENV_ROOT )); then
  path=($RBENV_ROOT/bin $path)
  path=($RBENV_ROOT/shims $path)
fi

if (( $+commands[rbenv] )); then
  eval "$(rbenv init - --no-rehash zsh)"
fi
