. "${HOME}/.config/shell/_base.sh"

if has asdf && $(asdf current direnv >/dev/null 2>&1) ; then
  eval "$(asdf exec direnv hook zsh)"
  direnv() { asdf exec direnv "$@"; }
fi
