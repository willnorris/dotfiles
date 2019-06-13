if [ -f ~/.profile ]; then
  . ~/.profile
fi

export PS1='\w\$ '

if [ -d "$HOME/.bash" ]; then
  for i in $HOME/.bash/*.bash; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi
