#!/bin/sh

if [ -d "$HOMEBREW_HOME/opt/fzf" ]; then
  export FZF_HOME="$HOMEBREW_HOME/opt/fzf"
fi

if [ -z "$FZF_HOME" ] && [ -d "$XDG_DATA_HOME/fzf" ]; then
  export FZF_HOME="${XDG_DATA_HOME}/fzf"
fi
if [ -z "$FZF_HOME" ] && [ -d "$XDG_DATA_HOME/nvim/site/pack/packer/start/fzf" ]; then
  export FZF_HOME="${XDG_DATA_HOME}/nvim/site/pack/packer/start/fzf"
fi

if [ -n "$FZF_HOME" ]; then
  pathadd "$FZF_HOME/bin"
fi

if has fzf; then
  if has fd; then
    export FZF_DEFAULT_COMMAND="fd --type file --hidden --follow --exclude .git --color always"
  fi
  export FZF_DEFAULT_OPTS="
  --color dark,bg+:8,gutter:-1,hl:1,hl+:1,info:2 --no-bold --height '40%' --reverse
  --preview '(bat -p --color always {} || cat {} || tree -C -L 1 -F {}) 2> /dev/null | head -300'
  --preview-window 'right:70%'
  --bind '?:toggle-preview,alt-j:preview-down,alt-k:preview-up'
  --bind 'alt-space:preview-page-down,alt-f:preview-page-down,alt-b:preview-page-up'
  --bind 'ctrl-f:page-down,ctrl-b:page-up'
  "
  export FZF_CTRL_R_OPTS="--no-reverse"
  export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

  #export FZF_TMUX=1

  # cd to recently opened directories (https://github.com/junegunn/fzf/wiki/Examples#z)
  j() {
    [ $# -gt 0 ] && _z "$*" && return
    cd "$(_z -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf-tmux +s --preview-window 'right:50%' --tac --query "$*")" || return
  }
fi
