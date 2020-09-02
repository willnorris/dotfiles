# Uncomment if using a dark background on cloudshell
#export COLORFGBG="15;0"

# Avoid background processes (https://github.com/rupa/z/issues/230)
unsetopt BG_NICE

# If not running interactively, return
case $- in
    *i*) ;;
      *) return;;
esac
if [ -f "/google/devshell/bashrc.google" ]; then
  source "/google/devshell/bashrc.google"
fi
