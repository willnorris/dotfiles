# Setup path-like variables
export -TU LD_LIBRARY_PATH ld_library_path
export -TU PYTHONPATH python_path

fpath+="$HOME/.zsh/functions"
autoload -Uz ~/.zsh/functions/*(N:t)
