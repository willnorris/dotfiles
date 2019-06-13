# vim: ft=zsh

if [ -f $GCLOUD_HOME/completion.zsh.inc ]; then
  source $GCLOUD_HOME/completion.zsh.inc
elif [ -f /usr/share/google-cloud-sdk/completion.zsh.inc ]; then
  source /usr/share/google-cloud-sdk/completion.zsh.inc
fi
