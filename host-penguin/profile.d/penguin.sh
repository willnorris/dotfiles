if [ -z "$DISPLAY" ]; then
  export $(systemctl --user show-environment | grep ^DISPLAY=)
fi

if [ "$TERM" = "xterm" ]; then
  export TERM="xterm-256color"
fi

alias chromium='sommelier -X --scale=0.5 --dpi=96 /usr/bin/chromium &'
alias code='sommelier -X --scale=0.4 --dpi=96 /usr/share/code/code "--unity-launch %F" &'
alias gimp='sommelier -X --scale=0.4 --dpi=96 /usr/bin/gimp &'
alias inkscape='sommelier -X --scale=0.4 --dpi=96 /usr/bin/inkscape &'
