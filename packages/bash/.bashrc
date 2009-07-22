#
# Primary bash(1) configuration file
#

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

HOSTNAME=`hostname | tr A-Z a-z`
HOST=${HOSTNAME%%.*}
DOMAIN=${HOSTNAME#*.}
OS=`uname | tr A-Z a-z`


[[ -r ${HOME}/.bash/all.pre.login ]] && source ${HOME}/.bash/all.pre.login
[[ -r ${HOME}/.bash/os/${OS}.login ]] && source ${HOME}/.bash/os/${OS}.login
[[ -r ${HOME}/.bash/network/${DOMAIN}.login ]] && source ${HOME}/.bash/network/${DOMAIN}.login

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
