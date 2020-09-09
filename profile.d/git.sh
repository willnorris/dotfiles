g () {
  if [ $# -gt 0 ]; then
    git "$@"
  else
    git s
    echo "" && git l -n 5
    echo "" && git b
  fi
}
