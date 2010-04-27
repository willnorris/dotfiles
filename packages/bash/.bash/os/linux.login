#
# $Id$
#

alias ls="/bin/ls --color=tty -F -b"

[[ `type xdg-open 2>/dev/null` ]] && alias open='xdg-open'


function fix-mouse {
  sudo modprobe -r usbhid ; sudo modprobe usbhid
}
