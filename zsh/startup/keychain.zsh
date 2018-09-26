if (( $+commands[keychain] )) && [[ -f $HOME/.ssh/id_rsa ]]; then
  eval `keychain --eval --quiet --agents ssh id_rsa`
fi
