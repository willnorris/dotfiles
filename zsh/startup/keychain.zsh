if (( $+commands[keychain] )); then
  eval `keychain --eval --quiet --agents ssh id_rsa`
fi
