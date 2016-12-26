# vim: ft=zsh

if (( $+GOROOT )); then
  path=($GOROOT/bin $path)
fi
