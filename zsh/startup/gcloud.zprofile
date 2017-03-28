# vim: ft=zsh

if (( $+GCLOUD_HOME )); then
  path=($GCLOUD_HOME/bin $path)
fi
