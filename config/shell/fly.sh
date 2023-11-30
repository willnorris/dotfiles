#!/bin/sh

if [ -r "${HOME}/.fly/bin/flyctl" ]; then
  export FLYCTL_INSTALL="${HOME}/.fly"
  pathadd "${FLYCTL_INSTALL}/bin"
fi
