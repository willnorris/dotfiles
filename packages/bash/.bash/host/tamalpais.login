#
# $Id$
#

#[ "$TERM" != "dumb" ] && stty erase 
#[ "$TERM" == "xterm-color" ] && TERM=xterm

#stty istrip
PATH=/usr/local/bin:/usr/local/sbin:/usr/xpg4/bin:/usr/bin:/usr/sbin:/usr/sfw/bin:/usr/openwin/bin:/usr/ccs/bin::/opt/mysql/current/bin

PS1COLOR='\[\033[0;32m\]' #green

#addToPath '/usr/local/bin'
#addToPath '/usr/local/sbin'
#addToPath '/usr/xpg4/bin'
#addToPath "$HOME/local/bin"
addToManPath "/usr/man"
addToManPath "/usr/local/man"

addToLibPath "/usr/local/lib"
addToLibPath "$HOME/local/lib"
addToLibPath "$HOME/local/bdb/lib"
addToLibPath "$HOME/local/bdb/include"

#setAppHome subversion $HOME/local/subversion
#setAppHome spamassassin $HOME/local/spamassassin

export MUTT_HOME="$HOME/local"

export EDITOR="vim"
export VISUAL="vim"

alias ls='ls -F --color=auto'
#alias vi='vim'
alias view='vim -R'

alias tar='gtar'
alias grep='ggrep'
alias sed='gsed'
alias find='gfind'
alias locate='glocate'
alias diff='gdiff'

export PERL5LIB="$HOME/local/lib/perl5/i386-solaris-thread-multi:$HOME/local/lib/perl5:$PERL5LIB"
export PYTHONPATH="$HOME/local/lib/python2.4/site-packages"
