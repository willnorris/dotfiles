#
# $Id$
#

#[[ -r /etc/bash_completion ]] && source /etc/bash_completion

export JAVA_HOME='/usr/lib/jvm/java-6-openjdk/jre'
setAppHome maven $HOME/local/apache-maven-2.2.1

# Directories & Paths
addToPath $HOME/local/google-appengine

PS1COLOR='\[\033[00;31m\]' #red

#source $HOME/.bash/other/google-dev.login

export apiary_url="http://ananias.mtv:10080/buzz/v1"
