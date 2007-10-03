##---------------------------------------------------------#
## ~/.bash/host/gds-shib1.login
##
## @author     William Norris <will@willnorris.com>
##---------------------------------------------------------#

source "$HOME/.bash/other/usc-servers.login"

setAppHome java	/var/local/jdk
setAppHome idp	/var/local/shibboleth-idp

PS1COLOR='\[\033[0;35m\]' #purple
