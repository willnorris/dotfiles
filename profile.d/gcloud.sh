if [ -z "$GCLOUD_HOME" ]; then
  if [ -d /opt/google-cloud-sdk ]; then
    export GCLOUD_HOME=/opt/google-cloud-sdk
  elif [ -d /usr/lib/google-cloud-sdk ]; then
    export GCLOUD_HOME=/usr/lib/google-cloud-sdk
  fi
fi

if [ -n "$GCLOUD_HOME" ]; then
  PATH="$GCLOUD_HOME/bin:$PATH"
fi
