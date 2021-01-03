# vim: ft=zsh

for config_file (${XDG_CONFIG_HOME}/zsh/startup/*.zshenv(rN)); do
  source $config_file
done
