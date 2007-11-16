#
# $Id$
#

source "$HOME/.bash/other/usc-servers.login"

addToPath "/var/local/sjes/ds/5.2/shared/bin"
addToPath "/var/local/sjes/ds/5.2"
addToLibPath "/var/local/sjes/ds/5.2/lib"

setAppHome GDS /var/local/gds

PERL5LIB="/var/local/gds/lib/perl:$PERL5LIB"

PS1COLOR='\[\033[0;32m\]' #green
