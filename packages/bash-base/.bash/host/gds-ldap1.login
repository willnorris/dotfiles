#---------------------------------------------------------#
## ~/.bash/host/gds-ldap1.login
##
## @author     William Norris <will@willnorris.com>
##---------------------------------------------------------#

source "$HOME/.bash/other/usc-servers.login"

#[ -z "$LD_LIBRARY_PATH" ] || export LD_LIBRARY_PATH=

addToPath "/var/local/sjes/ds/5.2/shared/bin"
addToPath "/var/local/sjes/ds/5.2"
addToLibPath "/var/local/sjes/ds/5.2/lib"

setAppHome GDS /var/local/gds
setAppHome GDSUTILS /var/local/gds/utilities

PERL5LIB="/var/local/gds/lib/perl:$PERL5LIB"

PS1COLOR='\[\033[0;32m\]' #green
