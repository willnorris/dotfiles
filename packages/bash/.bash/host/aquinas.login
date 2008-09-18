#
# $Id$
#

[ "$TERM" != "dumb" ] && stty erase 
TERM='xterm-color'

addToPath /usr/local/bin

# Directories & Paths
setAppHome 	java 	/Library/Java/Home
setAppHome 	maven 	/usr/local/maven
setAppHome 	tomcat 	/usr/local/tomcat
setAppHome 	idp 	/usr/local/shibboleth-idp
setAppHome 	ant 	/Developer/Java/Ant
setAppHome 	cayenne	/usr/local/cayenne
setAppHome 	mysql 	/usr/local/mysql
setAppHome 	mp 		/opt/mp
setAppHome	gds		/usr/local/gds
setAppHome	pear	/usr/local/pear

addToPath /usr/local/yuicompress/bin

export RSYNC_RSH='ssh'
#export TERM='xterm-color'

export RUBYOPT=rubygems
addToLibPath '/opt/mp/lib'

export MOZILLA_CERTIFICATE_FOLDER='/Users/wnorris/Library/Application Support/Firefox/Profiles/bds4wxjc.default'

alias sdf='unison hunting && ssh hunting unison -batch skat && ssh hunting unison -batch mariposa'
alias syn='/usr/local/synergy-1.3.1/synergys -c /usr/local/synergy-1.3.1/synergy.conf -a 127.0.0.1'
alias spamlearn='ssh mariposa spamlearn'

PS1COLOR='\[\033[0;34m\]' #blue

function resetvisor() {																		
	defaults write com.apple.Terminal VisorTerminal -dict-add Rows 20
	~/local/bin/visor-fix &																		
	killall Terminal																  
}

[[ "`whoami`" == "wnorris" ]] || PS1="[\\u]:\\w\\$"
