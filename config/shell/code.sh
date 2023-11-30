#!/bin/sh

# Prefer VS Code Insiders.  Alias 'code' to 'code-insiders' if we're running in
# a normal terminal or inside of VS Code Insiders.  The only time we don't
# setup this alias is if we're running inside of VS Code stable.  That way, if
# we're already in VS Code, 'code' will always point to the current version.
if [ "${TERM_PROGRAM}" != "vscode" ] || [[ "${TERM_PROGRAM_VERSION}" == *"-insider" ]]; then
  if has code-insiders; then
    alias code=code-insiders
  fi
fi
