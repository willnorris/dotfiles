if [ -f $GCLOUD_HOME/completion.bash.inc ]; then
  source $GCLOUD_HOME/completion.bash.inc
elif [ -f /usr/share/google-cloud-sdk/completion.bash.inc ]; then
  source /usr/share/google-cloud-sdk/completion.bash.inc
fi
