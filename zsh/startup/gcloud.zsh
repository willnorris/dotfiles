# vim: ft=zsh

if (( $+GCLOUD_HOME )); then
  path=($GCLOUD_HOME/bin $path)
fi

if [[ -f $GCLOUD_HOME/completion.zsh.inc ]]; then
  source $GCLOUD_HOME/completion.zsh.inc
fi
