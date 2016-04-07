setopt hist_expire_dups_first hist_ignore_space hist_no_functions \
  hist_no_store inc_append_history share_history
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
