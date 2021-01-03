if [ -f "${HOME}/.profile" ]; then
  source "${HOME}/.profile"
fi

mkdir -p "${XDG_DATA_HOME}/bash"
export HISTFILE="${XDG_DATA_HOME}/bash/history"

export PS1='\w\$ '

for config_file in ${XDG_CONFIG_HOME}/bash/*.bash; do
    source $config_file
done
unset i
