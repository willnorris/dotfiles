# vim: ft=zsh

export RBENV_ROOT=/opt/homebrew/var/rbenv

path=($HOME/Projects/jekyll/bin $path)

# Android Developer Tools
export ANDROID_HOME=/opt/android-sdk
export ANDROID_SDK=$ANDROID_HOME
path=($ANDROID_HOME/tools $ANDROID_HOME/platform-tools $path)

path=($GOPATH/src/camlistore.org/bin $path)

export LYNX_CFG=$HOME/.lynx.cfg
