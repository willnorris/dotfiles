[ -z "$PS1" ] && return # interactive only

if [ -z "$NVM_DIR" ] && [ -d $HOME/.nvm ]; then
  export NVM_DIR=$HOME/.nvm
fi

if [ -r "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh"
fi

if [ -r $NVM_DIR/bash_completion ]; then
  # this interferes with my compdef in git.zsh
  #source "$NVM_DIR/bash_completion"
  true
fi
