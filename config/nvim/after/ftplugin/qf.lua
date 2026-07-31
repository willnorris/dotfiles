-- config for quickfix window

local opt = { noremap = true, buf = 0, silent = true }

-- override j => gj and k => gk mappings
vim.keymap.set("n", "j", "j", opt)
vim.keymap.set("n", "k", "k", opt)
