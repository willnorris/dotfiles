# vim: ft=zsh

# set GOPATH to HOME if not already set
export GOPATH=${GOPATH:=$HOME}

if (( ! $+GOROOT )) && [[ -d /opt/go ]]; then
  export GOROOT=/opt/go
fi
