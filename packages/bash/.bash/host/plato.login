#
# $Id$
#

#[ "$TERM" != "dumb" ] && stty erase 
#[ "$TERM" == "xterm-color" ] && TERM=xterm

#stty istrip

PS1COLOR='\[\033[01;32m\]' #bright green

#addToPath '/usr/local/bin'
#addToPath '/usr/local/sbin'
#addToPath '/usr/xpg4/bin'
addToPath "$HOME/local/bin"
addToManPath "/usr/man"
addToManPath "/usr/local/man"

addToLibPath "/usr/local/lib"
addToLibPath "$HOME/local/lib"
addToLibPath "$HOME/local/bdb/lib"
addToLibPath "$HOME/local/bdb/include"

#setAppHome subversion $HOME/local/subversion
#setAppHome spamassassin $HOME/local/spamassassin

setAppHome MUTT $HOME/local

export EDITOR="vim"
export VISUAL="vim"

#alias ls='ls -F --color=auto'

#export PERL5LIB="$HOME/local/lib/perl5/i386-solaris-thread-multi:$HOME/local/lib/perl5:$PERL5LIB"
#export PYTHONPATH="$HOME/local/lib/python2.4/site-packages"
