-- Configure built-in neovim behavior.

-- General ====================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.maxmempattern = 2000
vim.o.mouse = ""
vim.o.switchbuf = "usetab"
vim.o.undofile = true

vim.o.shada = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)

-- Enable all filetype plugins and syntax (if not enabled, for better startup)
vim.cmd("filetype plugin indent on")
if vim.fn.exists("syntax_on") ~= 1 then vim.cmd("syntax enable") end

-- UI =========================================================================
vim.o.breakindent = true
vim.o.breakindentopt = "list:-1"
vim.o.cmdheight = 0
vim.o.colorcolumn = "+1" -- display column at edge of textwidth
vim.o.conceallevel = 0 -- don't conceal anything
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.o.diffopt = "internal,filler,vertical,closeoff"
vim.o.linebreak = true
vim.o.list = true
vim.o.listchars = "tab:> ,trail:-,extends:>,precedes:<,nbsp:+"
vim.o.number = true
vim.o.pumblend = 0     -- no transparency on popup menu
vim.o.splitkeep = "cursor"
vim.o.splitright = true
vim.o.wrap = true
vim.o.termguicolors = true

-- Set the list option only if expandtab is set.
-- This helps visualize erroneous tabs in a file that uses spaces.
-- Run on BufEnter after vim-sleuth has run.
vim.o.list = false
Config.autocmd("BufEnter", "*", function()
    if vim.bo.filetype == "noice" then
      return
    end
    if vim.bo.buftype == "nofile" then
      return
    end
    if vim.bo.expandtab then
      vim.wo.list = true
    end
  end,
  "set the list option if expandtab is set"
)

-- Folds
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 100           -- don't autofold anything
vim.o.foldnestmax = 3           -- maximum nesting
vim.opt.foldopen:append("jump") -- what movements open folds

-- Editing ====================================================================
vim.o.autoindent = true
vim.o.formatoptions = 'tcroqnl1j'
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.infercase = true
vim.o.shiftwidth = 2
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.spelloptions = "camel"
vim.o.tabstop = 2
vim.o.splitkeep = "screen"

vim.o.completeopt = "menuone,noselect"
vim.o.virtualedit = "block"
vim.opt.shortmess:append('WIcC')

vim.o.iskeyword = '@,48-57,_,192-255,-' -- Treat dash as `word` textobject part

-- Pattern for a start of numbered list (used in `gw`). This reads as
-- "Start of list item is: at least one special character (digit, -, +, *)
-- possibly followed by punctuation (. or `)`) followed by at least one space".
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

-- Built-in completion
vim.o.complete        = '.,w,b,kspell'                  -- Use less sources
vim.o.completeopt     = 'menuone,noselect,fuzzy,nosort' -- Use custom behavior
vim.o.completetimeout = 100                             -- Limit sources delay

-- Always use OSC52 clipboard
vim.g.clipboard = "osc52"
vim.keymap.set({ "n", "v" }, "Y", [["+y]], { desc = "Yank to system clipboard" })

-- Filetype aliases
vim.filetype.add {
  extension = {
    hujson = "json5",
  }
}

-- Diagnostics ================================================================

-- Neovim has built-in support for showing diagnostic messages. This configures
-- a more conservative display while still being useful.
-- See `:h vim.diagnostic` and `:h vim.diagnostic.config()`.
local diagnostic_opts = {
  -- Show signs on top of any other sign, but only for warnings and errors
  signs = { priority = 9999, severity = { min = 'WARN', max = 'ERROR' } },

  -- Show all diagnostics as underline (for their messages type `<Leader>ld`)
  underline = { severity = { min = 'HINT', max = 'ERROR' } },

  -- Show more details immediately for errors on the current line
  virtual_lines = false,
  virtual_text = {
    current_line = true,
    severity = { min = 'ERROR', max = 'ERROR' },
  },

  -- Don't update diagnostics when typing
  update_in_insert = false,
}

-- Use `later()` to avoid sourcing `vim.diagnostic` on startup
Config.later(function() vim.diagnostic.config(diagnostic_opts) end)

vim.cmd [[colorscheme wjn]]
