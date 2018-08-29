# vim: ft=zsh

if (( ! $+GOROOT )) && [[ -d /opt/go ]]; then
  export GOROOT=/opt/go
fi
