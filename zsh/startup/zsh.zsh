# Ignore commands that begin with '#'
set -k

# Allow for functions in the prompt.
setopt PROMPT_SUBST

# Autoload zsh functions.
fpath+="$HOME/.zsh/functions"
fpath+="$HOME/.zsh/completion"
fpath+="/opt/homebrew/share/zsh/site-functions"
autoload -U ~/.zsh/functions/*(:t)

autoload -U colors compinit
colors
compinit

zstyle ':completion:*' menu select=2

# Enable auto-execution of functions.
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# Append git functions needed for prompt if zsh has the regex module
zmodload zsh/regex &>/dev/null
if [[ $? -eq 0 ]]; then
  preexec_functions+='preexec_update_git_vars'
  precmd_functions+='precmd_update_git_vars'
  chpwd_functions+='chpwd_update_git_vars'
fi

precmd_functions+='precmd_set_xterm_title'

# use vi key bindings
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey "^?" backward-delete-char

# sane backspace behavior
zle -A .backward-kill-word vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char


# History
setopt hist_expire_dups_first hist_ignore_space hist_no_functions \
  hist_no_store inc_append_history share_history
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history


# Alias common commands to begin with a space so they don't appear in zsh
# history.  This is the closest I can come to Bash's HISTIGNORE setting
for c (fg bg jobs exit clear reset); do
  alias $c=" $c"
done

# TODO: eliminate the need for these host-specific configs or move to rvm
local file="${HOME}/.zsh/host/${SHORT_HOST}"
[[ -r ${file} ]] && source ${file}

# Set up the prompt
PROMPT='
%{$PROMPT_COLOR%}%~$(prompt_git_info)%{$PROMPT_COLOR%}
%# %{$reset_color%}'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


alias vi=vim
export EDITOR='vim'
export VISUAL=${EDITOR}
export PAGER='less'
export LYNX_LSS=${HOME}/.lynx.lss

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
source $HOME/.zsh/bundle/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
