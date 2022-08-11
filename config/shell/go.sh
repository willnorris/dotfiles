#!/usr/bin/env bash

export GOPATH="${HOME}/go"

if [ -d "${GOPATH}/bin" ]; then
  PATH="${GOPATH}/bin:$PATH"
fi
