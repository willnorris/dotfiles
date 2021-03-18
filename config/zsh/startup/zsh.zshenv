# Setup path-like variables
export -TU LD_LIBRARY_PATH ld_library_path
export -TU PYTHONPATH python_path

export ZDOTDIR=${XDG_CONFIG_HOME}/zsh
fpath+="${ZDOTDIR}/functions"
autoload -Uz ${ZDOTDIR}/functions/*(N:t)
