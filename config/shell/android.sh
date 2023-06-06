#!/bin/sh

# Location of Android Studio files on macOS
if [ -d "${HOME}/Library/Android/sdk/" ]; then
  export ANDROID_SDK_ROOT="${HOME}/Library/Android/sdk/"
fi
