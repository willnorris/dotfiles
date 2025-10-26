vim.cmd [[colorscheme wjn]]

-- Set leader first, since some plugins use it
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("mini.basics").setup({
  options = {
    basic = true,
    extra_ui = true,
    win_border = "solid",
  },
  mappings = {
    basic = true,
    options_toggle_prefix = "<Leader>u",
    windows = true,
  },
})

require("mini.extra").setup()

vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.cursorline = false

-- Keymaps
local keymap = vim.keymap.set

keymap("n", "<leader>bd", function() require("mini.bufremove").delete() end, { desc = "Close buffer" })
keymap("n", "H", "<cmd>bprev<cr>", { desc = "Go to previous buffer" })
keymap("n", "L", "<cmd>bnext<cr>", { desc = "Go to next buffer" })
