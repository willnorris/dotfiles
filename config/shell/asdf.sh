#!/bin/sh

export ASDF_DIR="${XDG_DATA_HOME}/asdf"
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
export ASDF_DATA_DIR="${ASDF_DIR}"

export ASDF_PYTHON_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME}/pip/default-python-packages"
export ASDF_NPM_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME}/npm/default-npm-packages"
export ASDF_GEM_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME}/gem/default-gems"

if [ ${SHLVL} -le 1 ]; then
  PATH="$ASDF_DIR/bin:$ASDF_DATA_DIR/shims:$PATH"
fi

# load asdf.sh as long as we're not in a subshell ($SHLVL > 1),
# in which case it should have already been loaded.
if [ -f "${ASDF_DIR}/asdf.sh" ]; then
  . "${ASDF_DIR}/asdf.sh"
fi
