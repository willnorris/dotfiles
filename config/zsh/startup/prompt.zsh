# vim: ft=zsh

setopt prompt_subst

autoload -Uz promptinit
autoload -Uz add-zsh-hook
promptinit
prompt pure

add-zsh-hook precmd prompt_willnorris_precmd

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
  prompt_willnorris_precmd
  prompt_pure_preprompt_render
}

prompt_willnorris_precmd() {
  # determine if prompt should be split, and how much to truncate path
  local min_height=$(( $LINES >= 20 ))
  local max_width=$(( $COLUMNS <= 50 ))

  # split prompt if sufficient vertical space or not enough width
  if (( $min_height || $max_width )); then
    prompt_newline=$'\n%{\r%}'

    psvar[21]=$(print -nP '%~')
    local zero='%([BSUbfksu]|([FK]|){*})'
    local expanded_prompt
    expanded_prompt="${(S%%)PROMPT//$~zero/}"
    cols=$(( $COLUMNS - ${#expanded_prompt} + ${(c)#$(print -nP '%~')} + 5))
    if (($cols > $COLUMNS)); then
      cols=$COLUMNS
    fi
    prompt_pure_state+=(pre_space true)
  else
    prompt_newline=' '
    prompt_pure_state+=(pre_space false)
    cols=$(( $COLUMNS * 1/4 ))
  fi

  psvar[21]=$(print -nP '%${cols}<…<%~%<<')
}
