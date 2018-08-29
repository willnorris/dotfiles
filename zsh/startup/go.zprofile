# vim: ft=zsh

if (( $+GOROOT )); then
  path=($GOROOT/bin $path)
fi

if [[ -d "$(go env GOPATH)/bin" ]]; then
  path=("$(go env GOPATH)/bin" $path)
fi
