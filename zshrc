# vim: ft=zsh

autoload -U compinit && compinit

typeset -U path manpath
path=($HOME/bin $path)
manpath=($HOME/man $manpath)

for config_file (~/.zsh/startup/*.zsh(rN)); do
  source $config_file
done

# append default system manpath
if [[ `uname` == "Darwin" ]]; then
  MANPATH="$MANPATH:"
else
  MANPATH="$MANPATH:$(manpath -g)"
fi
