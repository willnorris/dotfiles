##---------------------------------------------------------#
## ~/.bashrc 
##
## @author     William Norris <will@wirewater.org>
## @modified   2004-12-25 13:29
##---------------------------------------------------------#

HOST=`hostname | sed "s/\..*$//"`
DOMAIN=`hostname | sed "s/^[^\.]*//" | sed "s/^\.//"`

[ -f /etc/bashrc ] && [ -r /etc/bashrc ] && source /etc/bashrc
[ -f ~/.bash/all.logout ] && [ -r ~/.bash/all.logout ] && source ~/.bash/all.logout
[ -f ~/.bash/os/`uname`.logout ] && [ -r ~/.bash/os/`uname`.logout ] && source ~/.bash/os/`uname`.logout
[ -f ~/.bash/network/$DOMAIN.logout ] && [ -r ~/.bash/network/$DOMAIN.logout ] && source ~/.bash/network/$DOMAIN.logout
[ -f ~/.bash/host/$HOST.logout ] && [ -r ~/.bash/host/$HOST.logout ] && source ~/.bash/host/$HOST.logout

# the HOST variable above resolves to the non-fully-qualified hostname of the
# machine.  For example, it would not differentiate between the machines
# "foo.bar.com" and "foo.bar.net".  This last line allows you to create a file
# that uses the fully qualified hostname.  (note that this should only be
# necessary if you have two machines with the same name on two different
# networks)
[ -f ~/.bash/host/`hostname`.logout ] && [ -r ~/.bash/host/`hostname`.logout ] && [ "`hostname`" != $HOST ] && source ~/.bash/host/`hostname`.logout


setPS1
# eof
