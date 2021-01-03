# ~/.config/profile contains common configuration for bourne compatible shells.

# User Information
: ${EMAIL:="will@willnorris.com"}

# variables for default XDG user directories
: ${XDG_CONFIG_HOME:="${HOME}/.config"}
: ${XDG_CACHE_HOME:="${HOME}/.cache"}
: ${XDG_DATA_HOME:="${HOME}/.local/share"}

if [ -d "${XDG_CONFIG_HOME}/shell" ]; then
  for i in ${XDG_CONFIG_HOME}/shell/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi

# include ~/bin in PATH late to give precedence
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi
