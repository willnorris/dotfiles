# vim: ft=zsh

setopt prompt_subst

autoload -Uz promptinit
promptinit
prompt pure

local prompt_color=$(case $HOSTNAME in
  levi)   echo green;;
  rpi)    echo red;;
  esther) echo cyan;;
  vashti) echo cyan;;
  *)      echo blue;;
esac)

export PURE_PROMPT_SYMBOL="%#"
export PURE_PROMPT_VICMD_SYMBOL=":"
zstyle :prompt:pure:prompt:success color $prompt_color
zstyle :prompt:pure:path color $prompt_color

# re-render preprompt when window changes
TRAPWINCH() {
  prompt_pure_preprompt_render
}
