function g {
  if [[ $# > 0 ]]; then
    git "$@"
  else
    git status --short --branch
    echo "\n## Log" && git l -n 5
    echo "\n## Branches" && git b
  fi
}

compdef g='git'
