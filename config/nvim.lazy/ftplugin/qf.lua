-- config for quickfix window

local opt = { noremap = true, buffer = true, silent = true }

-- override j => gj and k => gk mappings
vim.keymap.set("n", "j", "j", opt)
vim.keymap.set("n", "k", "k", opt)

-- open in tab, split, and vsplit
vim.keymap.set("n", "<C-t>", "<C-W><CR><C-W>T", opt)
vim.keymap.set("n", "<C-x>", function() require("qf_helper").open_split("split") end, opt)
vim.keymap.set("n", "<C-v>", function() require("qf_helper").open_split("vsplit") end, opt)
