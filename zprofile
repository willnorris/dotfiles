# vim: ft=zsh

typeset -U path manpath
path=(
  $HOME/bin
  $path
)
manpath=(
  $HOME/man
  $manpath
)

for config_file (~/.zsh/startup/*.zprofile(rN)); do
  source $config_file
done
