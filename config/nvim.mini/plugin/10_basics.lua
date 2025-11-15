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

vim.o.cmdheight = 0
vim.o.cursorline = false
vim.o.shiftwidth = 2
vim.o.tabstop = 2
