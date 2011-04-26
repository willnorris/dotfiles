#[[ -r /etc/bash_completion ]] && source /etc/bash_completion

PS1COLOR='\[\033[00;31m\]' #red
export apiary_url="http://${HOSTNAME}:10080/buzz/v1"
