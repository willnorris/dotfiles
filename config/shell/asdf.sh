# install asdf with:
#   git clone https://github.com/asdf-vm/asdf.git ${XDG_DATA_HOME}/asdf

export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"

export ASDF_PYTHON_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME}/pip/default-python-packages"
export ASDF_NPM_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME}/npm/default-npm-packages"
export ASDF_GEM_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME}/gem/default-gems"

if [ -f "${ASDF_DATA_DIR}/asdf.sh" ]; then
  . "${ASDF_DATA_DIR}/asdf.sh"
fi
