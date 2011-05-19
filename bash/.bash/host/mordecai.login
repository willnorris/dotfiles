#
# $Id$
#

[ "$TERM" != "dumb" ] && stty erase 
TERM='xterm-color'

# Directories & Paths
setAppHome 	fink 		/sw
#setAppHome 	macports 	/opt/macports
setAppHome 	mysql 		/usr/local/mysql
setAppHome 	homebrew 	/opt/homebrew
setAppHome 	pear 		/usr/local/pear
setAppHome 	go 		$HOME/Projects/go

addToPath $HOMEBREW_HOME/Cellar/python/2.7.1/bin

PS1COLOR='\[\033[0;34m\]' #blue

