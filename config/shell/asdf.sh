# install asdf with:

export ASDF_DIR="${XDG_DATA_HOME}/asdf"
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
export ASDF_DATA_DIR="${ASDF_DIR}"

export ASDF_PYTHON_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME}/pip/default-python-packages"
export ASDF_NPM_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME}/npm/default-npm-packages"
export ASDF_GEM_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME}/gem/default-gems"

if [ -f "${ASDF_DIR}/asdf.sh" ]; then
  . "${ASDF_DIR}/asdf.sh"
fi
