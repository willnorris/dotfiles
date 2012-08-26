[ "$TERM" != "dumb" ] && stty erase 
TERM='xterm-color'

setAppHome 	homebrew 	/opt/homebrew

addToPath `brew --prefix python`/bin
source `brew --prefix grc`/etc/grc.bashrc

PS1COLOR='\[\033[0;34m\]' #blue

