local trouble = require("trouble")

trouble.setup {
  fold_open = "",
  fold_closed = "",
  indent_lines = false,
  use_diagnostic_signs = true,
}

local wk_ok, wk = pcall(require, "which-key")
if wk_ok then wk.register({ ["<leader>x"] = { name = "+trouble" } }) end

vim.keymap.set("n", "<leader>xx", "<Cmd>TroubleToggle<CR>")
vim.keymap.set("n", "<leader>xw", "<Cmd>Trouble workspace_diagnostics<CR>")
vim.keymap.set("n", "<leader>xd", "<Cmd>Trouble document_diagnostics<CR>")
vim.keymap.set("n", "<leader>xl", "<Cmd>Trouble loclist<CR>")
vim.keymap.set("n", "<leader>xq", "<Cmd>Trouble quickfix<CR>")
