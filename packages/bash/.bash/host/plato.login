#
# $Id$
#

PS1COLOR='\[\033[00;31m\]' #red

[[ -r /etc/bash_completion ]] && source /etc/bash_completion

[[ `type xdg-open 2>/dev/null` ]] && alias open='xdg-open'
