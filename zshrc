# vim: ft=zsh

autoload -U compinit && compinit

for config_file (~/.zsh/startup/*.zsh(rN)); do
  source $config_file
done
