# vim: ft=zsh

if (( ! $+HOMEBREW_HOME )) && [[ -d /opt/homebrew ]]; then
  export HOMEBREW_HOME=/opt/homebrew
fi
