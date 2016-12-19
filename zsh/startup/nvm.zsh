# vim: ft=zsh

if (( ! $+NVM_DIR )) && [[ -d $HOME/.nvm ]]; then
  export NVM_DIR=$HOME/.nvm
fi

if [[ -e $NVM_DIR/nvm.sh ]]; then
  source "$NVM_DIR/nvm.sh"
fi
