# vim: ft=zsh

autoload -U colors && colors
PROMPT_COLOR="%{${fg[blue]}%}"

if (( $+commands[rbenv] )); then
  eval "$(rbenv init - --no-rehash zsh)"
fi
