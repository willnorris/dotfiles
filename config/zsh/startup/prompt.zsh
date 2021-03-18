# vim: ft=zsh

setopt prompt_subst

autoload -Uz promptinit
promptinit
prompt pure

export PURE_PROMPT_SYMBOL="%%"
zstyle :prompt:pure:prompt:success color blue
