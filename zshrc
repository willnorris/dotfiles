# vim: ft=zsh

autoload -U compinit && compinit
typeset -U path manpath

# load common shell configuration
if [ -f ~/.profile ]; then
  emulate sh -c 'source .profile'
fi

for config_file (~/.zsh/startup/*.zsh(rN)); do
  source $config_file
done

manpath=($HOME/man $manpath)

# append default system manpath
if [[ `uname` == "Darwin" ]]; then
  MANPATH="$MANPATH:"
else
  MANPATH="$MANPATH:$(manpath -g)"
fi
