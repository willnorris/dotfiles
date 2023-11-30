#!/bin/sh
# shellcheck disable=SC2016

# load or start named tmux session (https://github.com/bag-man/dotfiles/blob/c88cc45/bashrc)
tm() {
  [ -n "$TMUX" ] && change="switch-client" || change="attach-session"
  if [ "$1" ]; then
    tmux "$change" -t "$1" 2>/dev/null || (tmux new-session -d -s "$1" && tmux "$change" -t "$1")
    return
  fi
  session=$(command tmux list-sessions -F "#{session_name}" 2>/dev/null |
    fzf-tmux --exit-0 --preview='printf "Clients:\n$(tmux list-clients -t {})\n\nWindows:\n$(tmux list-windows -t {})"') &&
    tmux "$change" -t "$session" || echo "No sessions found."
}
