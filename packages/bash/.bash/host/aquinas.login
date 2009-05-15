#
# $Id$
#

[ "$TERM" != "dumb" ] && stty erase 
TERM='xterm-color'

addToPath /usr/local/bin
addToManPath /usr/local/man

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
setAppHome	yuicompressor  /usr/local/yuicompressor

export RSYNC_RSH='ssh'
#export TERM='xterm-color'

export RUBYOPT=rubygems
addToLibPath '/opt/mp/lib'

export MOZILLA_CERTIFICATE_FOLDER='/Users/wnorris/Library/Application Support/Firefox/Profiles/bds4wxjc.default'

[[ `which gsed &>/dev/null` ]] && alias sed='gsed'

alias sdf='unison hunting && ssh hunting unison -batch skat && ssh hunting unison -batch mariposa'
alias syn='/usr/local/synergy-1.3.1/synergys -c /usr/local/synergy-1.3.1/synergy.conf -a 127.0.0.1'
alias spamlearn='ssh mariposa spamlearn'
alias ff2='/Applications/Firefox2.app/Contents/MacOS/firefox -P ff2'

# grc aliases
if [ "$TERM" != dumb ] && [ `which grc &>/dev/null` ] ; then
	alias cl='grc -es --colour=auto'
	alias configure='cl ./configure'
	alias diff='cl diff'
	alias make='cl make'
	alias gcc='cl gcc'
	alias g++='cl g++'
	alias as='cl as'
	#alias gas='cl gas'
	alias ld='cl ld'
	alias netstat='cl netstat'
	alias ping='cl ping'
	alias traceroute='cl /usr/sbin/traceroute'
	alias cat='cl cat'
	alias tail='cl tail'
	#alias perl='cl perl'
	#alias python='cl python'
fi

PS1COLOR='\[\033[0;34m\]' #blue

function resetvisor() {																		
	defaults write com.apple.Terminal VisorTerminal -dict-add Rows 20
	~/local/bin/visor-fix &																		
	killall Terminal																  
}

[[ "`whoami`" == "wnorris" ]] || PROMPT="[\\u] \\x\\$"
