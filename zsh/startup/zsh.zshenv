# User Information
export NAME="Will Norris"
export EMAIL="will@willnorris.com"

# Setup path-like variables
export -TU LD_LIBRARY_PATH ld_library_path
export -TU PYTHONPATH python_path

fpath+="$HOME/.zsh/functions"
autoload -Uz ~/.zsh/functions/*(N:t)

# Setup host-specific environment variables.  This is used for
# loading zsh config files based on the current hostname.
SHORT_HOST=${HOST%%.*}
