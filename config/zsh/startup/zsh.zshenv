# Setup path-like variables
export -TU LD_LIBRARY_PATH ld_library_path
export -TU PYTHONPATH python_path

fpath+="${XDG_CONFIG_HOME}/zsh/functions"
autoload -Uz ${XDG_CONFIG_HOME}/zsh/functions/*(N:t)
