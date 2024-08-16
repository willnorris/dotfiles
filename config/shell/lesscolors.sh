# Adapted from posts:
# - https://unix.stackexchange.com/q/119
# - https://unix.stackexchange.com/q/108699
#
# shellcheck disable=SC2155

export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 4) # blue
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
export LESS_TERMCAP_se=$(tput sgr0)
export LESS_TERMCAP_us=$(tput bold; tput setaf 1) # red
export LESS_TERMCAP_ue=$(tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)

# use classic less rendering in newer groff versions for man pages
export GROFF_NO_SGR=1
