# vim: ft=zsh

setopt prompt_subst

autoload -Uz promptinit
autoload -Uz add-zsh-hook
promptinit
prompt pure

add-zsh-hook precmd prompt_pure_precustom

local prompt_color=$(case $HOSTNAME in
  levi)   echo green;;
  rpi)    echo red;;
  esther) echo cyan;;
  vashti) echo cyan;;
  llm-sandbox) echo red;;
  *)      echo blue;;
esac)

export PURE_PROMPT_SYMBOL="%#"
export PURE_GIT_DOWN_ARROW="↓"
export PURE_GIT_UP_ARROW="↑"
export PURE_PROMPT_VICMD_SYMBOL=":"
export PURE_CMD_MAX_EXEC_TIME=3
zstyle :prompt:pure:prompt:success color $prompt_color
zstyle :prompt:pure:path color $prompt_color
zstyle :prompt:pure:user:root color red

# re-render preprompt when window changes
TRAPWINCH() {
  prompt_pure_preprompt_render
}

prompt_pure_precustom() {
  # determine if prompt should be split, and how much to truncate path
  local min_height=$(( $LINES >= 20 ))
  local max_width=$(( $COLUMNS <= 50 ))

  # split prompt if sufficient vertical space or not enough width
  if (( $min_height || $max_width )); then
    zstyle :prompt:pure:preprompt newline true
    local zero='%([BSUbfksu]|([FK]|){*})'
    local expanded_prompt="${(S%%)PROMPT//$~zero/}"
    cols=$(( $COLUMNS - ${#expanded_prompt} + ${(c)#$(print -nP '%~')} + 5))
    if (($cols > $COLUMNS)); then
      cols=$COLUMNS
    fi
  else
    zstyle :prompt:pure:preprompt newline false
    cols=$(( $COLUMNS * 1/4 ))
  fi

  typeset -g prompt_pure_path_segment="%F{$prompt_pure_colors[path]}$(print -nP '%${cols}<…<%~%<<')%f"
}
