function zshaddhistory() {
    emulate -L zsh

    # don't write production tailscale keys to history
    if [[ $1 = *"tskey-"*"CNTRL"* ]] ; then
        return 1
    fi

    # don't write history if env var is set
    if [[ "$ZSH_NO_HISTORY" == "1" ]]; then
        return 1
    fi
}
