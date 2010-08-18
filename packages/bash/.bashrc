#
# Primary bash(1) configuration file
#

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

HOSTNAME=`hostname`
# allow for vanity hostname override
if [[ -r "/etc/vanity-hostname" ]]; then
  HOSTNAME=`cat /etc/vanity-hostname`
fi

HOSTNAME=`echo ${HOSTNAME} | tr A-Z a-z`
HOST=${HOSTNAME%%.*}
OS=`uname | tr A-Z a-z`

# build networks array -- this allows for login scripts that apply to increasinly more specific
# portions of a network.  For example, given the hostname 'server.sfo.example.com', the NETWORKS
# array would be: ( 'com', 'example.com', 'sfo.example.com' )
DOMAIN=${HOSTNAME#*.}
NETWORKS=()
while [[ "$HOST" != "$DOMAIN" && -n $DOMAIN ]]
do
  [ "$DOMAIN" == "${NETWORKS[0]}" ] && break
  NETWORKS=( "$DOMAIN" "${NETWORKS[@]}" )
  DOMAIN=${DOMAIN#*.}
done
DOMAIN=


[[ -r ${HOME}/.bash/all.pre.login ]] && source ${HOME}/.bash/all.pre.login
[[ -r ${HOME}/.bash/os/${OS}.login ]] && source ${HOME}/.bash/os/${OS}.login

# iterate through networks
for NETWORK in "${NETWORKS[@]}"
do
  [[ -r ${HOME}/.bash/network/${NETWORK}.login ]] && source ${HOME}/.bash/network/${NETWORK}.login
done

# hostname or default -- this is necessary when I plugin to something like a DSL
# line and it assigns me some weird hostname based on the ip address.
if [[ -r ${HOME}/.bash/host/${HOST}.login ]]; then 
	source ${HOME}/.bash/host/${HOST}.login
else
	source ${HOME}/.bash/host/default.login
fi


# The HOST variable above resolves only to the local portion of the machine 
# hostname. For example, it would not differentiate between the machines
# "foo.bar.com" and "foo.example.com".  This last line allows you to create 
# a file that uses the fully qualified hostname.  
#
# Note that this should only be necessary if you have two machines with the 
# same name on two different networks and they need individual configurations
if [[ "$HOSTNAME" != "$HOST" && -r ${HOME}/.bash/host/${HOSTNAME}.login ]]; then
   source ${HOME}/.bash/host/${HOSTNAME}.login
fi


#FROM_HOST=`getConnectingHost`
#FROM_DOMAIN=`echo $FROM_HOST | sed -r "s/^.*?\.([^\.]*\.[^\.]*)$/\1/"`
#if [ -r $HOME/.bash/fromhost/$FROM_HOST.login ]; then
#	source $HOME/.bash/fromhost/$FROM_HOST.login
#fi
#
#if [ -r $HOME/.bash/fromhost/$FROM_DOMAIN.login ]; then
#	source $HOME/.bash/fromhost/$FROM_DOMAIN.login
#fi


[[ -r ${HOME}/.bash/all.post.login ]] && source ${HOME}/.bash/all.post.login

#EOF
