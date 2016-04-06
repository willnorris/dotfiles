# User Information
export NAME="Will Norris"
export EMAIL="will@willnorris.com"

# Setup path-like variables
typeset -U path manpath
export -TU LD_LIBRARY_PATH ld_library_path
export -TU PYTHONPATH python_path


# Setup host-specific environment variables.  This is primarily used for
# loading zsh config files based on the current OS, network, and machine
# hostname.

HOSTNAME=$HOST
# allow for vanity hostname override
[[ -r /etc/vanity-hostname ]] && HOSTNAME=`cat /etc/vanity-hostname`
[[ -r $HOME/.vanity-hostname ]] && HOSTNAME=`cat $HOME/.vanity-hostname`

HOSTNAME=$HOSTNAME:l
HOST=${HOSTNAME%%.*}
OS=${$(uname):l}

# build networks array -- this allows for login scripts that apply to
# increasinly more specific portions of a network.  For example, given the
# hostname 'server.sfo.example.com', the NETWORKS array would be: ( 'com',
# 'example.com', 'sfo.example.com' )
DOMAIN=${HOSTNAME#*.}
NETWORKS=()
while [[ $HOST != $DOMAIN && -n $DOMAIN ]]
do
  [[ "$DOMAIN" == "${NETWORKS[1]}" ]] && break
  NETWORKS=( "$DOMAIN" "${NETWORKS[@]}" )
  DOMAIN=${DOMAIN#*.}
done
DOMAIN=


# Load host-specific env files

# iterate through networks
for NETWORK in "${NETWORKS[@]}"
do
  [[ -r ${HOME}/.zsh/network/${NETWORK}.env ]] &&  \
    source ${HOME}/.zsh/network/${NETWORK}.env
done

local file="${HOME}/.zsh/host/${HOST}.env"
[[ -r ${file} ]] && source ${file}


# Lastly, add directories in $HOME
path=($HOME/bin $path)
manpath=($HOME/man $manpath)

