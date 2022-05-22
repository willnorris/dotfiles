local fn = vim.fn
local keymap = vim.keymap.set

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path, })
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  use 'fatih/vim-go'
  use 'google/vim-jsonnet'
  use 'joshdick/onedark.vim'
  use 'junegunn/gv.vim'
  use 'konfekt/vim-sentence-chopper'
  use 'kshenoy/vim-signature'
  use 'majutsushi/tagbar'
  use 'michaeljsmith/vim-indent-object'
  use 'ojroques/vim-oscyank'
  use 'scrooloose/nerdcommenter'
  use 'sheerun/vim-polyglot'
  use 'sickill/vim-pasta'
  use 'tpope/vim-afterimage'
  use 'tpope/vim-commentary'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-git'
  use 'tpope/vim-repeat'
  use 'tpope/vim-sensible'
  use 'tpope/vim-sleuth'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-vinegar'

  use 'editorconfig/editorconfig-vim'
  vim.g.EditorConfig_exclude_patterns = {'fugitive://.*'}

  use 'sjl/gundo.vim'
  vim.g.gundo_preview_bottom = 1
  vim.g.gundo_prefer_python3 = 1
  keymap("n", "<leader>u", ":GundoToggle<CR>")

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
        }
      }
    end,
  }
  keymap("n", "yogg", ":Gitsigns toggle_signs<CR>")

  use 'zhaocai/GoldenView.vim'
  vim.g.goldenview__enable_default_mapping = 0
  keymap("n", "yogv", ":ToggleGoldenViewAutoResize<CR>")

  use 'mileszs/ack.vim'
  if fn.executable("rg") == 1 then
    vim.opt.grepprg = "rg --vimgrep --no-heading"
    vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
    vim.g.ackprg = "rg --vimgrep --no-heading"
  end

  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'
  vim.g.limelight_conceal_ctermfg = 8
  keymap("n", "<leader>gg", ":Goyo<CR>")
  vim.cmd [[autocmd! User GoyoEnter Limelight]]
  vim.cmd [[autocmd! User GoyoLeave Limelight!]]

  use {'junegunn/fzf', run = './install --bin' }
  use 'junegunn/fzf.vim'
  vim.g.fzf_history_dir = '$XDG_DATA_HOME/vim/fzf-history'
  vim.g.fzf_action = {
    ["ctrl-t"] = 'tab split',
    ["ctrl-s"] = 'split',
    ["ctrl-v"] = 'vsplit',
  }
  vim.g.fzf_layout = { down = '~70%' }
  keymap("n", "<C-T>", ":FZF<CR>")

  use 'w0rp/ale'
  vim.g.ale_lint_on_text_changed = 'normal'
  vim.g.ale_lint_on_insert_leave = 1
  vim.g.ale_fixers = {
     javascript = {'eslint'},
  }
  vim.cmd [[highlight ALEErrorSign ctermfg=8 ctermbg=1]]

  use {
    "nvim-lualine/lualine.nvim",
    config = function()
      -- customize 16color theme, swap insert and normal color
      local t16c = require 'lualine.themes.16color'
      local normal = t16c.normal.a
      t16c.normal.a = t16c.insert.a
      t16c.insert.a = normal
      t16c.normal.a.fg = '#000000'
      t16c.insert.a.fg = '#000000'
      t16c.visual.a.fg = '#000000'

      require('lualine').setup {
        options = {
          theme = t16c,
          icons_enabled = false,
          section_separators = '',
          component_separators = '',
        },
        sections = {
          lualine_a = {
            { 'mode', fmt = function(str) return str:sub(1,1) end }
          },
        },
        tabline = {
          lualine_a = { {'buffers', mode=2} },
          lualine_z = { {'tabs', mode=2} },
        }
      }
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
