##---------------------------------------------------------#
## ~/.bash/host/mariposa.login
##
## @author     William Norris <will@wirewater.org>
## @modified   2004-05-30 13:29
##---------------------------------------------------------#

[ "$TERM" != "dumb" ] && stty erase 

PS1COLOR='\[\033[0;32m\]' #green

addToPath "$HOME/local/bin"
addToManPath "$HOME/local/man"

setAppHome subversion $HOME/local/subversion
setAppHome spamassassin $HOME/local/spamassassin
