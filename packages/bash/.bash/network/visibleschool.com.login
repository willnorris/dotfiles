#!/bin/bash
##---------------------------------------------------------#
## ~/.bash/network/visibleschool.com.login
##
## @author     William Norris <will@wirewater.org>
## @modified   2003-11-22 13:29
##---------------------------------------------------------#

umask 0002

#----------------------------------------------------------#
# Environment Variables 
#----------------------------------------------------------#
# -- path to DarwinPorts
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# -- Visible School in-house scripts
export PATH="/usr/local/visible/bin:/usr/local/visible/sbin:$PATH"

PS1="[\\h]:\\w\\$"
