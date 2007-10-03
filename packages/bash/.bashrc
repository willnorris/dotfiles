##---------------------------------------------------------#
## $HOME/.bashrc 
##
## @author     William Norris <will@willnorris.com>
## @modified   2005-08-05
##---------------------------------------------------------#

HOST=`hostname | sed "s/\..*$//"`
DOMAIN=`hostname | sed "s/^[^\.]*//" | sed "s/^\.//"`


[[ -r /etc/bashrc ]] && source /etc/bashrc
[[ -r $HOME/.bash/all.pre.login ]] && source $HOME/.bash/all.pre.login
[[ -r $HOME/.bash/os/`uname`.login ]] && source $HOME/.bash/os/`uname`.login
[[ -r $HOME/.bash/network/$DOMAIN.login ]] && source $HOME/.bash/network/$DOMAIN.login


# hostname or default -- this is necessary when I plugin to something like a DSL
# line and it assigns me some weird hostname based on the ip address.
if [[ -r $HOME/.bash/host/$HOST.login ]]; then 
	source $HOME/.bash/host/$HOST.login
else
	source $HOME/.bash/host/aquinas.login
fi


# the HOST variable above resolves to the non-fully-qualified hostname of the
# machine.  For example, it would not differentiate between the machines
# "foo.bar.com" and "foo.bar.net".  This last line allows you to create a file
# that uses the fully qualified hostname.  (note that this should only be
# necessary if you have two machines with the same name on two different
# networks and they need individual configurations)
[[ -r $HOME/.bash/host/`hostname`.login && "`hostname`" != "$HOST" ]] && source $HOME/.bash/host/`hostname`.login


#FROM_HOST=`getConnectingHost`
#FROM_DOMAIN=`echo $FROM_HOST | sed -r "s/^.*?\.([^\.]*\.[^\.]*)$/\1/"`
#if [ -r $HOME/.bash/fromhost/$FROM_HOST.login ]; then
#	source $HOME/.bash/fromhost/$FROM_HOST.login
#fi
#
#if [ -r $HOME/.bash/fromhost/$FROM_DOMAIN.login ]; then
#	source $HOME/.bash/fromhost/$FROM_DOMAIN.login
#fi


[[ -r $HOME/.bash/all.post.login ]] && source $HOME/.bash/all.post.login

#EOF
