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

vim.cmd([[
  nnoremap yof :call FoldColumnToggle()<cr>
  function! FoldColumnToggle()
      if &foldcolumn
          setlocal foldcolumn=0
      else
          setlocal foldcolumn=1
      endif
  endfunction
]])

-- Netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = -28
