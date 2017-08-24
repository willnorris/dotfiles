# Always start a chroot environment and sshd inside of termux.
if [[ $HOME == *"/com.termux/"* && -z "$SHELL" ]]; then
  if ! pgrep -f "termux-chroot" >/dev/null; then echo "[Starting chroot...]" && termux-chroot; else echo "[chroot is running]"; fi
  if ! pgrep "sshd" >/dev/null; then echo "[Starting sshd...]" && sshd && echo "[OK]"; else echo "[sshd is running]"; fi
fi
