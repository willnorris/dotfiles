-- config for quickfix window

local keymap = vim.keymap.set
local opt = { noremap = true, buffer = true, silent = true }

-- override j => gj and k => gk mappings
keymap("n", "j", "j", opt)
keymap("n", "k", "k", opt)

-- open in tab, split, and vsplit
keymap("n", "<C-t>", "<C-W><CR><C-W>T", opt)
keymap("n", "<C-x>", [[<cmd>lua require"qf_helper".open_split("split")<CR>]], opt)
keymap("n", "<C-v>", [[<cmd>lua require"qf_helper".open_split("vsplit")<CR>]], opt)
