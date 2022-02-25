export GOPATH="${HOME}/go"

if command -v go >/dev/null; then
  if [ -d "$(go env GOPATH)/bin" ]; then
    PATH="$(go env GOPATH)/bin:$PATH"
  fi
fi
