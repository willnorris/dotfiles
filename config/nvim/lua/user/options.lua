local o = vim.opt

-- general
o.wildmode = "list:longest,full"
o.updatetime = 100
o.maxmempattern = 2000
o.spellfile = vim.fn.stdpath("config") .. "/en.utf-8.add"
o.undofile = true
o.timeoutlen = 500

-- UI
o.listchars = "tab:> ,trail:-,extends:>,precedes:<,nbsp:+"
o.number = true -- show line numbers
o.splitright = true -- open vertical splits on the right
o.showmode = false
o.cursorlineopt = "number"

-- Set the list option if expandtab is set.  This helps visualize erroneous
-- tabs in a file that is otherwise indented with spaces.  Run on BufEnter
-- after vim-sleuth has run.
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.o.expandtab then
      vim.o.list = true
    end
  end,
})

-- Scrolling and Wrapping
o.scrolloff = 3
o.sidescrolloff = 10
o.linebreak = true

-- Text Formatting / Layout
o.ignorecase = true
o.smartcase = true
o.infercase = true

-- Indents
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true
o.breakindent = true

o.diffopt = "filler,vertical"

-- Folding
o.foldenable = true -- turn on folding
o.foldmethod = "indent" -- fold on indent level
o.foldlevel = 100 -- don't autofold anything
o.foldopen = "block,hor,mark,percent,quickfix,tag" -- what movements open folds

vim.cmd [[
  nnoremap yof :call FoldColumnToggle()<cr>
  function! FoldColumnToggle()
      if &foldcolumn
          setlocal foldcolumn=0
      else
          setlocal foldcolumn=1
      endif
  endfunction
]]

-- Netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = -28

-- Signs and Diagnostics
local signs = {
  { name = "DiagnosticSignError", text = "e" },
  { name = "DiagnosticSignWarn", text = "w" },
  { name = "DiagnosticSignInfo", text = "i" },
  { name = "DiagnosticSignHint", text = "h" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
  -- enable virtual text
  virtual_text = true,
  -- show signs
  signs = {
    active = signs,
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})
