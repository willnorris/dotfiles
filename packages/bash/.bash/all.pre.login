#
# $Id$
#

#[ -w /dev/console ] && echo "executing ~/.bash/all.pre.login" > /dev/console

#[ "$TERM" == "xterm" ] && TERM="xterm-color"

# this needs to be before any environment variable assignment
set -a

#----------------------------------------------------------#
# Environment Variables 
#----------------------------------------------------------#
# User Information
NAME="Will Norris"
EMAIL="will@willnorris.com"

# Default Programs 
# (several more are defined in all.post.login so they can use the updated $PATH)
EDITOR="vi"
VISUAL=${EDITOR}
BROWSER="lynx"

# Prevent common commands from being added to .bash_history
HISTIGNORE="&:ls:mutt:jobs:[bf]g:exit"


#----------------------------------------------------------#
# Aliases 
#----------------------------------------------------------#
# if vi is not already set to run vim and vim does exist on the system, add an alias
#[[ "`vi --version 2>/dev/null | awk 'NR==1 { print $1 }'`" != "VIM" ]] && which vim > /dev/null 2>&1 && alias vi='vim'

[[ -f ${HOME}/.lynx.cfg ]] && alias lynx='lynx -cfg=~/.lynx.cfg'
alias listen='netstat -an | grep -i listen | grep -iE "(tcp|udp)"'
alias 'check-shib'='ssh skat check-shib'


# setup bash options
set -o vi
set -o ignoreeof

shopt -s cdspell
shopt -s cmdhist
shopt -s dotglob
shopt -s extglob
shopt -s histappend

unset PS1

# custom functions
[[ -r ${HOME}/.bash/functions ]] && source ${HOME}/.bash/functions

# try to maintain LD_LIBRARY_PATH when using `sudo -s`
[[ -z "${LD_LIBRARY_PATH}" ]] && [[ ! -z "${PATH_LD_BAK}" ]] && LD_LIBRARY_PATH=${PATH_LD_BAK}

