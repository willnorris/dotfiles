# vim: ft=zsh

if (( ! $+GOROOT )) && [[ -d /opt/go ]]; then
  export GOROOT=/opt/go
fi

# enable go 1.11 modules
export GO111MODULE=on
