# vim: ft=zsh

# disable global rc files and manually load instead.  This allows us to prevent
# loading /etc/zprofile on OSX 11.x
# setopt no_global_rcs
if [ -f /etc/zshenv ]; then
  source /etc/zshenv
fi

for config_file (~/.zsh/startup/*.zshenv(rN)); do
  source $config_file
done
