if [ -z "$GOROOT" ] && [ -d /opt/go ]; then
  export GOROOT=/opt/go
fi

if [ -n "$GOROOT" ]; then
  PATH="$GOROOT/bin:$PATH"
fi

if command -v go >/dev/null; then
  if [ -d "$(go env GOPATH)/bin" ]; then
    PATH="$(go env GOPATH)/bin:$PATH"
  fi
fi
