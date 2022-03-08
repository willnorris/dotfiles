# vim: ft=zsh

source "${XDG_CONFIG_HOME}/shell/asdf.sh"

if [[ -d ${ASDF_DIR}/completions ]]; then
  fpath+="${ASDF_DIR}/completions"
fi
