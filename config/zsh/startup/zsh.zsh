# Ignore commands that begin with '#'
set -k

# Keep lots of shell history and save it to ~/.local/share/zsh/history
setopt hist_expire_dups_first hist_ignore_space hist_no_functions \
  hist_no_store share_history extended_history
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
HISTFILE="${XDG_DATA_HOME}/zsh/history"

# Autoload zsh functions.
fpath+="${XDG_CONFIG_HOME}/zsh/completion"

zstyle ':completion:*' menu select=2

# use vi key bindings
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins '^[' vi-cmd-mode
bindkey "^?" backward-delete-char

# sane backspace behavior
zle -A .backward-kill-word vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char

# Alias common commands to begin with a space so they don't appear in zsh
# history.  This is the closest I can come to Bash's HISTIGNORE setting
for c (fg bg jobs exit clear reset); do
  alias $c=" $c"
done

if has zsh-patina; then
  eval "$(zsh-patina activate)"
fi
