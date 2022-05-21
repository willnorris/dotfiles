
vim.opt.ts = 8
vim.opt.sw = 8
vim.opt.et = false
vim.opt.list = false

-- Go has no max line-length, but set colorcolumn as a reference
vim.opt.colorcolumn = "81"

local keymap = vim.keymap.set
keymap("n", "<LocalLeader>i", "<Plug>(go-info)")
keymap("n", "<LocalLeader>f", ":GoImports<CR>")

keymap("n", "<LocalLeader>r", "<Plug>(go-run)")
keymap("n", "<LocalLeader>b", "<Plug>(go-build)")
keymap("n", "<LocalLeader>t", "<Plug>(go-test)")
keymap("n", "<LocalLeader>c", "<Plug>(go-coverage)")

vim.g.go_def_mapping_enabled = 0 -- disable mapping that interferes with fzf
vim.g.go_highlight_functions = 1
vim.g.go_highlight_methods = 1
vim.g.go_highlight_structs = 1
vim.g.go_highlight_operators = 1
vim.g.go_highlight_build_constraints = 1
vim.g.go_highlight_types = 1
vim.g.go_highlight_operators = 1
