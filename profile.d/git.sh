g () {
  if [ $# -gt 0 ]; then
    git "$@"
  else
    git status --short --branch
    echo "
## Log" && git l -n 5
    echo "
## Branches" && git b
  fi
}
