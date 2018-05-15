# Ignore commands that begin with '#'
set -k

# Autoload zsh functions.
fpath+="$HOME/.zsh/completion"

zstyle ':completion:*' menu select=2

# use vi key bindings
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey "^?" backward-delete-char

# disable tty stop and start
stty stop ''
stty start ''

# sane backspace behavior
zle -A .backward-kill-word vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char


# Alias common commands to begin with a space so they don't appear in zsh
# history.  This is the closest I can come to Bash's HISTIGNORE setting
for c (fg bg jobs exit clear reset); do
  alias $c=" $c"
done

if grep --color "a" <<< "a" &>/dev/null; then
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

if (( $+commands[rg] )); then
  alias rg='rg -S'
  alias ack='rg'
elif (( $+commands[ag] )); then
  alias ack='ag'
fi

alias vi=vim
export EDITOR='vim'
export VISUAL=${EDITOR}
export PAGER='less'
export LYNX_LSS=${HOME}/.lynx.lss

if [[ -d "$HOME/.zsh/bundle/zsh-syntax-highlighting" ]]; then
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
  source $HOME/.zsh/bundle/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
ZSH_HIGHLIGHT_STYLES[comment]=fg=yellow,bold

function encmount {
  [ -z "$1" ] && echo "volumne not specified" 2>&1 && return 1
  if [[ `uname` == "Darwin" ]]; then
    encfs "$HOME/.googledrive/Documents/$1.enc" "$HOME/.$1" -- -o volname="$1"
  else
    encfs "$HOME/.googledrive/Documents/$1.enc" "$HOME/.$1"
  fi
}
