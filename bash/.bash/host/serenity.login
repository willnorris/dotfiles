#
# $Id$
#

[ "$TERM" != "dumb" ] && stty erase 
TERM='xterm-color'

addToManPath /usr/local/man

# Directories & Paths
setAppHome 	java 		/Library/Java/Home
setAppHome 	homebrew 		/opt/homebrew

export RUBYOPT=rubygems

alias dircolors='gdircolors'

PS1COLOR='\[\033[0;36m\]' #teal

[[ "`whoami`" == "willnorris" ]] || PROMPT="[\\u] \\x\\$"
