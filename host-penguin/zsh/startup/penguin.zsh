if [ -z "$DISPLAY" ]; then
  export $(systemctl --user show-environment | grep ^DISPLAY=)
fi

if [[ "$TERM" == "xterm" ]]; then
  export TERM="xterm-256color"
fi
