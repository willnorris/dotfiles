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
export PURE_GIT_DOWN_ARROW=""
export PURE_GIT_UP_ARROW=""
export PURE_PROMPT_VICMD_SYMBOL=":"
export PURE_CMD_MAX_EXEC_TIME=3
zstyle :prompt:pure:prompt:success color $prompt_color
zstyle :prompt:pure:path color $prompt_color
zstyle :prompt:pure:user:root color red

# re-render preprompt when window changes
TRAPWINCH() {
  prompt_pure_preprompt_render
}
