[ -z "$PS1" ] && return # interactive only

if command -v rg >/dev/null; then
  alias rg='rg -S'
  alias ack='rg'
elif command -v ag >/dev/null; then
  alias ack='ag'
fi

if command -v batcat >/dev/null; then
  alias bat='batcat'
fi
if command -v bat >/dev/null; then
  export BAT_THEME="ansi-light"
  export BAT_STYLE="plain"
  alias cat='bat'
fi


alias vi=vim
export EDITOR='vim'
export VISUAL=${EDITOR}
export PAGER='less'
export LYNX_LSS=${HOME}/.lynx.lss

if echo "a" | grep --color "a" >/dev/null 2>/dev/null; then
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Set $HOSTNAME environment variables, which is used in other places for
# host-specific configuration
if command -v scutil >/dev/null; then
  export HOSTNAME="$(scutil --get ComputerName)"
fi
if [ -z "$HOSTNAME" ]; then
  export HOSTNAME="${HOST%%.*}"
fi


encmount () {
  [ -z "$1" ] && echo "volumne not specified" 2>&1 && return 1
  if [ `uname` = "Darwin" ]; then
    encfs "$HOME/.googledrive/Documents/$1.enc" "$HOME/.$1" -- -o volname="$1"
  else
    encfs "$HOME/.googledrive/Documents/$1.enc" "$HOME/.$1"
  fi
}
