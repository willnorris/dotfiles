-- general
vim.o.wildmode = "list:longest,full"
vim.o.updatetime = 100
vim.o.maxmempattern = 2000
vim.o.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
vim.o.undofile = true
vim.o.timeoutlen = 500

vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages"

-- UI
vim.o.listchars = "tab:> ,trail:-,extends:>,precedes:<,nbsp:+"
vim.o.number = true -- show line numbers
vim.o.splitright = true -- open vertical splits on the right
vim.o.showmode = false
vim.o.cursorlineopt = "number"
vim.o.hidden = false -- don't show hidden buffers

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
vim.o.scrolloff = 3
vim.o.sidescrolloff = 10
vim.o.linebreak = true

-- Text Formatting / Layout
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.infercase = true

-- Indents
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.breakindent = true

vim.o.diffopt = "filler,vertical"

-- Folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

vim.o.foldlevel = 100 -- don't autofold anything
vim.o.foldnestmax = 3 -- maximum nesting
vim.opt.foldopen:append("jump") -- what movements open folds

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
