# ~/.profile contains common configuration for bourne compatible shells.

# User Information
export NAME="Will Norris"
export EMAIL="will@willnorris.com"

if [ -d "$HOME/.profile.d" ]; then
  for i in $HOME/.profile.d/*.sh; do
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
