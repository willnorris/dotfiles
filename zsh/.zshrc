autoload -U colors compinit
colors
compinit
 
# Ignore commands that begin with '#'
set -k

# Allow for functions in the prompt.
setopt PROMPT_SUBST
 
# Autoload zsh functions.
fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

# Enable auto-execution of functions.
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# Append git functions needed for prompt.
preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'

# use vi key bindings
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode

# sane backspace behavior
zle -A .backward-kill-word vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char


# History
setopt hist_ignore_all_dups hist_ignore_space hist_no_functions \
  hist_no_store share_history append_history
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history


# Alias common commands to begin with a space so they don't appear in zsh
# history.  This is the closest I can come to Bash's HISTIGNORE setting
for c (ls fg bg jobs exit clear reset); do
  alias $c=" $c"
done

[[ -r ${HOME}/.zsh/os/${OS} ]] && source ${HOME}/.zsh/os/${OS}
[[ ${OS} != ${OSTYPE} ]] && [[ -r ${HOME}/.zsh/os/${OSTYPE} ]] && \
  source ${HOME}/.zsh/os/${OSTYPE}

# iterate through networks
for NETWORK in "${NETWORKS[@]}"
do
  [[ -r ${HOME}/.zsh/network/${NETWORK} ]] &&  \
    source ${HOME}/.zsh/network/${NETWORK}
done

# hostname or default -- this is necessary when I plugin to something like a
# DSL line and it assigns me some weird hostname based on the ip address.
if [[ -r ${HOME}/.zsh/host/${HOST} ]]; then
  source ${HOME}/.zsh/host/${HOST}
else
  source ${HOME}/.zsh/host/default
fi

# The HOST variable above resolves only to the local portion of the machine
# hostname. For example, it would not differentiate between the machines
# "foo.bar.com" and "foo.example.com".  This last line allows you to create
# a file that uses the fully qualified hostname.
#
# Note that this should only be necessary if you have two machines with the
# same name on two different networks and they need individual configurations
if [[ "$HOSTNAME" != "$HOST" && -r ${HOME}/.zsh/host/${HOSTNAME} ]]; then
   source ${HOME}/.zsh/host/${HOSTNAME}
fi


# Set up the prompt
PROMPT='
%{$PROMPT_COLOR%}%~$(prompt_git_info)%{$PROMPT_COLOR%}
%# %{$reset_color%}'

# Let's add a little color to the world
# grc aliases
if [ "$TERM" != "dumb" ] && [ `whence grc` ]; then
  alias cl='grc -es --colour=auto'
  alias configure='cl ./configure'
  alias diff='cl diff'
  alias make='cl make'
  alias gcc='cl gcc'
  alias g++='cl g++'
  alias as='cl as'
  #alias gas='cl gas'
  alias ld='cl ld'
  alias netstat='cl netstat'
  alias ping='cl ping'
  alias traceroute='cl /usr/sbin/traceroute'
  alias cat='cl cat'
  alias tail='cl tail'
  #alias perl='cl perl'
  #alias python='cl python'
fi

# enable color support of ls (may be named dircolors or gdircolors)
eval "`dircolors -b $HOME/.bash/dircolors.ansi-dark 2>/dev/null`"
eval "`gdircolors -b $HOME/.bash/dircolors.ansi-dark 2>/dev/null`"

# have `ls` output color if it knows how
if [[ -n `ls --version 2>/dev/null | grep coreutils` ]]; then
  alias ls=' ls --color=auto -F'
fi

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


alias vi=vim
export EDITOR='vim'
export VISUAL=${EDITOR}
export PAGER='less'

export ACK_PAGER=${PAGER}
export ACK_PAGER_COLOR='less -R'
