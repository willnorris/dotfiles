#!/usr/bin/env bash

[ -z "$PS1" ] && return # interactive only

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if has batcat; then
  alias bat='batcat'
fi
if has bat; then
  export BAT_THEME="OneHalfDark"
  export BAT_STYLE="plain"
  alias cat='bat'
fi

if ! has fd && has fdfind; then
  alias fd='fdfind'
fi

alias vi=vim
alias view='vim -R'
alias vimdiff='vim -d'
export EDITOR='vim'
if has nvim; then
  alias vim=nvim
  EDITOR='nvim'
fi
if [ "${TERM_PROGRAM}" = "vscode" ]; then
  EDITOR='code -w'
fi
export VISUAL=${EDITOR}
export PAGER='less'
export LYNX_LSS=${HOME}/.lynx.lss

# Use rg output with a pager
# https://github.com/BurntSushi/ripgrep/issues/181
rg() {
  command rg -p "$@" | less -RFX
}

if echo "a" | grep --color "a" >/dev/null 2>&1; then
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Set $HOSTNAME environment variables, which is used in other places for
# host-specific configuration
if has scutil; then
  HOSTNAME="$(scutil --get ComputerName)"
fi
if [ -z "$HOSTNAME" ]; then
  HOSTNAME="${HOST%%.*}"
fi
export HOSTNAME

export _Z_DATA="${XDG_DATA_HOME}/z/db"

encmount () {
  [ -z "$1" ] && echo "volumne not specified" 2>&1 && return 1
  if [ "$(uname)" = "Darwin" ]; then
    encfs "$HOME/.googledrive/Documents/$1.enc" "$HOME/.$1" -- -o volname="$1"
  else
    encfs "$HOME/.googledrive/Documents/$1.enc" "$HOME/.$1"
  fi
}
