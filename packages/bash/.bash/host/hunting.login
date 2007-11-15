#
# $Id$
#

# SSH keychain
/usr/bin/keychain $HOME/.ssh/id_dsa > /dev/null 2>&1
[ -f $HOME/.keychain/hunting.usc.edu-sh ] && source $HOME/.keychain/hunting.usc.edu-sh > /dev/null
#[ -f $HOME/.ssh-agent ] && source $HOME/.ssh-agent > /dev/null


PS1COLOR='\[\033[0;31m\]' #green
PS1_NO_TITLEBAR="true"

setAppHome	java		/usr/lib/jvm/java-1.5.0-sun
setAppHome	tomcat		/opt/local/tomcat
setAppHome	catalina	/opt/local/tomcat
setAppHome	idp			/var/local/shibboleth-idp-trunk
setAppHome	sp			/opt/local/shibboleth-sp
setAppHome	gds			/opt/local/gds
setAppHome	gdsutils	/opt/local/gds/utilities
setAppHome  maven	   /opt/local/maven-2.0.7

alias syn='ssh -f -N -L 24800:127.0.0.1:24800 aquinas && /usr/bin/synergyc localhost'

function sdf {
	echo "synchronizing with server (aquinas)"
	unison $@ aquinas

	echo "synchronizing with server (skat)"
	unison $@ skat

	echo "synchronizing with server (tamalpais)"
	unison $@ tamalpais

	#echo "synchronizing with server (mozart)"
	#unison $@ mozart
}

[ "$TERM" != "dumb" ] && stty erase 
TERM='xterm-color'

#set display if empty -- mainly necessary when using screen
[ -z "$DISPLAY" ] && export DISPLAY=":0.0"

# bash_completion
#[ -r $HOME/.bash/bash_completion ] && source $HOME/.bash/bash_completion
