# vim: ft=zsh

if (( ! $+GCLOUD_HOME )) && [[ -d /opt/google-cloud-sdk ]]; then
  export GCLOUD_HOME=/opt/google-cloud-sdk
fi
