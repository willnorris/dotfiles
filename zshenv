# vim: ft=zsh

for config_file (~/.zsh/startup/*.zshenv(rN)); do
  source $config_file
done
