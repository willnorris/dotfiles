# vim: ft=zsh

setopt prompt_subst

autoload -Uz promptinit
promptinit
prompt pure

local color=$(case $HOSTNAME in
  levi)   echo green;;
  rpi)    echo red;;
  esther) echo cyan;;
  vashti) echo cyan;;
  *)      echo blue;;
esac)

export PURE_PROMPT_SYMBOL="%#"
zstyle :prompt:pure:prompt:success color $color
zstyle :prompt:pure:path color $color
