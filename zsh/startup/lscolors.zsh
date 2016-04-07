# Setup ls colors

if [[ -r ~/.config/personal/dircolors ]]; then
  if (( $+commands[gdircolors] )); then
    eval $(gdircolors ~/.config/personal/dircolors)
  elif (( $+commands[dircolors] )); then
    eval $(dircolors ~/.config/personal/dircolors)
  fi
fi

if (( $+commands[gls] )); then
  alias ls=" gls --color=auto -F -N"
elif ls --color=auto &>/dev/null; then
  alias ls=" ls --color=auto -F"
else
  # Incase we're using BSD ls with color support.
  export CLICOLOR=1
  export LSCOLORS="Gxfxcxdxbxegedabagacad"
  alias ls=" ls -F"
fi
