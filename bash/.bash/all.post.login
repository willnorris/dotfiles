#
# This bash(1) config file is read during login on all machines,
# after any host or OS specific files
#

PROMPT_COMMAND='setPS1'

addToPath $HOME/bin
addToPath $HOME/local/bin
addToManPath $HOME/local/man

addToPath $HOME/Projects/oacurl

export JPY=$HOME/.bash/j2/j.py
source $HOME/.bash/j2/j.sh

# use local cacert file for git
[ -r "$HOME/.cacert.pem" ] && GIT_SSL_CERT="$HOME/.cacert.pem"

## setup some more defaults, now that the value of PATH is correct for the local system

# Set vi alias if need be
VIM_VERSION=`vi --version 2>/dev/null`
if [[ ${VIM_VERSION:0:3} == "VIM" ]]; then
  export EDITOR="vi"
else
  which vim &> /dev/null && alias vi='vim' && export EDITOR='vim'
fi
unset VIM_VERSION

VIM=$HOME/.vim/

export VISUAL=${EDITOR}
export PAGER="less"

export ACK_PAGER=$PAGER
export ACK_PAGER_COLOR="less -R"


#----------------------------------------------------------#
# Let's add a little color to the world
#----------------------------------------------------------#
# grc aliases
if [[ "$TERM" != "dumb" && `type -P grc` ]]; then
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
if [[ `ls --version 2>/dev/null | grep coreutils` ]]; then
   alias ls &> /dev/null || alias ls="ls --color=auto -F"
fi

alias s='screen'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


# try to maintain LD_LIBRARY_PATH when using `sudo -s`
export PATH_LD_BAK=${LD_LIBRARY_PATH}

#source ~/.bash/bash_completion

[ ! -z "$MACPORTS_HOME" ] && addToPathVar "PYTHONPATH" "$MACPORTS_HOME/lib/python2.5/site-packages"
