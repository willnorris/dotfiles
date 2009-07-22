#
# This bash(1) config file is read during login on all machines, 
# after any host or OS specific files
#

PROMPT_COMMAND='setPS1'

addToPath $HOME/bin
addToPath $HOME/local/bin
addToManPath $HOME/local/man

export JPY=$HOME/.bash/j2/j.py
source $HOME/.bash/j2/j.sh


## setup some more defaults, now that the value of PATH is correct for the local system

# Set vi alias if need be
VIM_VERSION=`vi --version 2>/dev/null`
if [[ ${VIM_VERSION:0:3} == "VIM" ]]; then
	export EDITOR="vi"
else
   	which vim &> /dev/null && alias vi='vim' && export EDITOR='vim'
fi
unset VIM_VERSION

export VISUAL=${EDITOR}
export PAGER="less"


# TODO: perhaps setup `dircolors` here?

# have `ls` output color if it knows how
if [[ `ls --version 2>/dev/null | grep coreutils` ]]; then
   alias ls &> /dev/null || alias ls="ls --color=auto -F"
fi


# try to maintain LD_LIBRARY_PATH when using `sudo -s`
export PATH_LD_BAK=${LD_LIBRARY_PATH}

#source ~/.bash/bash_completion

