# vim: ft=zsh

for config_file (~/.zsh/startup/*.zprofile(rN)); do
  source $config_file
done
