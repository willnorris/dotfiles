vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
})

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

require("mini.statusline").setup()
require("mini.tabline").setup()
require("mini.git").setup()
require("mini.diff").setup({
  view = {
    style = "sign",
    signs = { add = "+", change = "~", delete = '_' }
  }
})

vim.o.cursorline = false
