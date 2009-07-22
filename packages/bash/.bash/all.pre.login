#
# This bash(1) config file is read during login on all machines, 
# before any host or OS specific files
#

# this needs to be before any environment variable assignment
# set -a

#----------------------------------------------------------#
# Environment Variables 
#----------------------------------------------------------#
# User Information
export NAME="Will Norris"
export EMAIL="will@willnorris.com"

# Default Programs 
# (several more are defined in all.post.login so they can use the updated $PATH)
export BROWSER="lynx"


#----------------------------------------------------------#
# Bash Options 
#----------------------------------------------------------#
set -o vi
set -o ignoreeof

shopt -s cdspell
shopt -s cmdhist
shopt -s dotglob
shopt -s extglob

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# Bash History Options

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Prevent common commands from being added to .bash_history
export HISTIGNORE="&:ls:mutt:jobs:[bf]g:exit"


#----------------------------------------------------------#
# Aliases 
#----------------------------------------------------------#
[[ -f ${HOME}/.lynx.cfg ]] && alias lynx='lynx -cfg=~/.lynx.cfg'
alias listen='netstat -an | grep -i listen | grep -iE "(tcp|udp)"'


# Load custom functions
[[ -r ${HOME}/.bash/functions ]] && source ${HOME}/.bash/functions

# try to maintain LD_LIBRARY_PATH when using `sudo -s`
[[ -z "${LD_LIBRARY_PATH}" ]] && [[ ! -z "${PATH_LD_BAK}" ]] && export LD_LIBRARY_PATH=${PATH_LD_BAK}

