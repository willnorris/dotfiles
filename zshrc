# vim: ft=zsh

if [ -f /etc/zshrc ]; then
  source /etc/zshrc
fi

for config_file (~/.zsh/startup/*.zsh(rN)); do
  source $config_file
done
