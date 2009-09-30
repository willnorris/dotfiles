#
# $Id$
#

[ "$TERM" != "dumb" ] && stty erase 
TERM='xterm-color'

addToManPath /usr/local/man

# Directories & Paths
setAppHome 	java 		/Library/Java/Home
setAppHome 	maven 		/usr/local/maven
setAppHome 	tomcat 		/usr/local/tomcat
setAppHome 	idp 		/usr/local/shibboleth-idp
setAppHome 	ant 		/Developer/Java/Ant
setAppHome 	cayenne		/usr/local/cayenne
setAppHome 	mysql 		/usr/local/mysql
setAppHome 	macports	/opt/mp
setAppHome	gds			/usr/local/gds
#setAppHome	pear		/usr/local/pear
setAppHome	yuicompressor  /usr/local/yuicompressor

export RSYNC_RSH='ssh'

export RUBYOPT=rubygems
addToLibPath '/opt/mp/lib'

export MOZILLA_CERTIFICATE_FOLDER='/Users/willnorris/Library/Application Support/Firefox/Profiles/qp6dkslr.default'

alias syn='/usr/local/synergy-1.3.1/synergys -c /usr/local/synergy-1.3.1/synergy.conf -a 127.0.0.1'
alias ff2='/Applications/Firefox2.app/Contents/MacOS/firefox -P ff2'
alias dircolors='gdircolors'

PS1COLOR='\[\033[0;34m\]' #blue

# Local perl modules
export PERL5LIB="$HOME/local/lib/perl5/i386-solaris-thread-multi:$HOME/local/lib/perl5:$PERL5LIB"
addToPath $HOME/local/perl/bin
addToManPath $HOME/local/perl/man


function resetvisor() {
	defaults write com.apple.Terminal VisorTerminal -dict-add Rows 20
	~/local/bin/visor-fix &
	killall Terminal
}

[[ "`whoami`" == "willnorris" ]] || PROMPT="[\\u] \\x\\$"

[[ -r ${MACPORTS_HOME}/etc/bash_completion ]] && source ${MACPORTS_HOME}/etc/bash_completion

