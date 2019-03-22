# vim: ft=zsh

if [[ -e $NVM_DIR/nvm.sh ]]; then
  source "$NVM_DIR/nvm.sh"
fi

if [[ -e $NVM_DIR/bash_completion ]]; then
  # this interferes with my compdef in git.zsh
  #source "$NVM_DIR/bash_completion"
fi
