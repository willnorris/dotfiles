#!/usr/bin/zsh

function appendToAlias
{
  if [ ${#@} -ge 2 ]; then
    args=($@); unset args[0]
    ALIAS_CMD=`alias $1 2>/dev/null || echo "alias $1='$1'"`
    ALIAS_CMD="${ALIAS_CMD%\'} ${args[@]}'"
    eval "$ALIAS_CMD"
  fi
}

function sdr
{
  if [ -z "$@" ]; then
    screen -U -D -R
  else
    screen -U -D -R $@
  fi
}

# wrapper for screen that exports a few environment variables
function screen
{
  unset SCREEN_SESSION_NAME
  export _HOST=$HOST
  export _DISPLAY=$DISPLAY

  args=("$@")
  for ((i=0; i<${#args[@]} ; i++)); do
    if [ ${args[i]} == "-S" ]; then
      export SCREEN_SESSION_NAME=${args[i+1]}
    fi
  done

  command screen "$@"
}

#function getConnectingHost
#{
#  foo=`tty | sed "s/\/dev\///"` && who | grep -E "\W$foo\W" | sed -r "s/.*\((.*)\)/\1/"
#}
