# vim: ft=zsh

if (( ! $+NVM_DIR )) && [[ -d $HOME/.nvm ]]; then
  export NVM_DIR=$HOME/.nvm
fi
