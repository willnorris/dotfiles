# vim: ft=zsh

if (( $+commands[rbenv] )); then
  eval "$(rbenv init - --no-rehash zsh)"
fi
