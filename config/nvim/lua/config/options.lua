-- general
vim.o.wildmode = "list:longest,full"
vim.o.maxmempattern = 2000
vim.o.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
vim.o.clipboard = ""

-- UI
vim.o.listchars = "tab:> ,trail:-,extends:>,precedes:<,nbsp:+"
vim.o.relativenumber = false -- no relative line numbers
vim.o.splitbelow = false -- open horizontal splits on top
vim.o.cursorlineopt = "number"
vim.o.hidden = false -- don't show hidden buffers
vim.o.mouse = false
vim.o.pumblend = 0 -- no transparency on popup menu
vim.o.conceallevel = 0 -- don't conceal anything

vim.opt.hlsearch = true
vim.opt.colorcolumn = "+1" -- display column at edge of textwidth

-- Set the list option only if expandtab is set.
-- This helps visualize erroneous tabs in a file that uses spaces.
-- Run on BufEnter after vim-sleuth has run.
vim.o.list = false
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.o.expandtab then
      vim.o.list = true
    end
  end,
})

vim.o.linebreak = true
vim.o.infercase = true
vim.o.breakindent = true
vim.o.diffopt = "filler,vertical"
vim.o.wrap = true

-- Folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 100 -- don't autofold anything
vim.o.foldnestmax = 3 -- maximum nesting
vim.opt.foldopen:append("jump") -- what movements open folds
