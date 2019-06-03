if [ -z "$GCLOUD_HOME" ] && [ -d /opt/google-cloud-sdk ]; then
  export GCLOUD_HOME=/opt/google-cloud-sdk
fi

if [ -n "$GCLOUD_HOME" ]; then
  PATH="$GCLOUD_HOME/bin:$PATH"
fi
