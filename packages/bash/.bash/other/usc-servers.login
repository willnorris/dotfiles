#!/bin/bash
##---------------------------------------------------------#
## ~/.bash/other/usc-servers.login
##
## @author     William Norris <will@wirewater.org>
## @modified   2003-11-22 13:29
##---------------------------------------------------------#

[ ! "${MANPATH}" ] && export MANPATH=/usr/man:/usr/openwin/man:/usr/share/man:/usr/usc/man

#addToPath		/usr/ucb
addToPath		/bin
addToPath		/sbin
addToPath		/usr/usc/bin
addToPath		/usr/lsd/sbin
addToPath		/usr/lsd/bin
addToManPath	/usr/lsd/man

source "/usr/usc/curl/default/setup.sh"
source "/usr/usc/jdk/default/setup.sh"
source "/usr/usc/gnu/coreutils/default/setup.sh"
source "/usr/usc/gnu/tar/default/setup.sh"
source "/usr/usc/gnu/findutils/default/setup.sh"
source "/usr/usc/gnu/grep/default/setup.sh"
source "/usr/usc/gnu/sed/default/setup.sh"
source "/usr/usc/subversion/1.4.3/setup.sh"

setAppHome  csw     /opt/csw
setAppHome	php		/usr/usc/php/default
setAppHome	vim		/usr/usc/vim/7.0

addToPath	/usr/usc/gnu/gawk/default/bin
[ `which gawk` ] && alias awk='gawk'

PERL5LIB="$HOME/local/perl/lib/perl5:$PERL5LIB"
PS1="[\\h]:\\w\\$"
