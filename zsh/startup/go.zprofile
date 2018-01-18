# vim: ft=zsh

if (( $+GOROOT )); then
  path=($GOROOT/bin $path)
fi

path=($GOPATH/src/perkeep.org/bin $path)
