#
# $Id$
#

[ "$TERM" != "dumb" ] && stty erase 
TERM='xterm-color'

# Directories & Paths
setAppHome 	fink 		/sw
setAppHome 	macports 	/opt/macports
setAppHome 	mysql 		/usr/local/mysql
setAppHome 	pear 		/usr/local/pear

PS1COLOR='\[\033[0;34m\]' #blue

