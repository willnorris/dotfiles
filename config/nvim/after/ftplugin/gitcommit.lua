-- automatically show diff when running 'git commit'
vim.cmd [[if winnr("$") == 1
  DiffGitCached | wincmd J | wincmd p
endif]]
