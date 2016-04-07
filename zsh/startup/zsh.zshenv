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

# TODO: eliminate the need for these host-specific configs or move to rvm
local file="${HOME}/.zsh/host/${SHORT_HOST}.env"
[[ -r ${file} ]] && source ${file}
