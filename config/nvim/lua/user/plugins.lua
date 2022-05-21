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
  use 'junegunn/gv.vim'
  use 'konfekt/vim-sentence-chopper'
  use 'kshenoy/vim-signature'
  use 'majutsushi/tagbar'
  use 'michaeljsmith/vim-indent-object'
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
  use 'joshdick/onedark.vim'

  use 'editorconfig/editorconfig-vim'
  vim.g.EditorConfig_exclude_patterns = {'fugitive://.*'}

  use 'sjl/gundo.vim'
  vim.g.gundo_preview_bottom = 1
  vim.g.gundo_prefer_python3 = 1
  keymap("n", "<leader>u", ":GundoToggle<CR>")

  use 'airblade/vim-gitgutter'
  keymap("n", "yogg", ":GitGutterToggle<CR>")

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

  -- Airline {{{
  use 'vim-airline/vim-airline'

  vim.g.airline_theme_patch_func = 'AirlineThemePatch'
  vim.cmd [[
  function! AirlineThemePatch(palette)
    if g:airline_theme == 'onedark'
      let a:palette.normal.airline_c[3] = 0
      let a:palette.normal.airline_x[3] = 0
    endif
  endfunction
  ]]

  vim.g.airline_theme = 'onedark'
  vim.cmd [[
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  ]]
  vim.g.airline_left_sep = ''
  vim.g.airline_right_sep = ''

  vim.g.airline_mode_map = {
      __ = '-',
      n  = 'N',
      i  = 'I',
      R  = 'R',
      c  = 'C',
      v  = 'V',
      V  = 'V_',
      ["^V"]  = '-V',
      s  = 'S',
      S  = 'S:_',
      ["^S"]  = '^S',
      t  = 'T',
  }

  vim.g.airline_symbols.branch = ''
  vim.g.airline_symbols.crypt = '⚿'
  vim.g.airline_symbols.paste = '∥'
  vim.g.airline_symbols.spell = 'Ꞩ'

  vim.g["airline#parts#ffenc#skip_expected_string"] = "utf-8[unix]"
  vim.g["airline#extensions#hunks#non_zero_only"] = 1

  vim.g["airline#extensions#ale#enabled"] = 1
  vim.g["airline#extensions#ale#error_symbol"] = '⚠:'
  vim.g["airline#extensions#ale#warning_symbol"] = '⦸:'

  vim.g["airline#extensions#tabline#enabled"] = 1
  vim.g["airline#extensions#tabline#show_splits"] = 1
  vim.g["airline#extensions#tabline#tab_nr_type"] = 2
  vim.g["airline#extensions#tabline#buffer_idx_mode"] = 1
  vim.g["airline#extensions#tabline#left_sep"] = ' '
  vim.g["airline#extensions#tabline#left_alt_sep"] = '|'
  vim.g["airline#extensions#tabline#show_close_button"] = 0

  keymap("n", "<A-1>", "<Plug>AirlineSelectTab1")
  keymap("n", "<A-2>", "<Plug>AirlineSelectTab2")
  keymap("n", "<A-3>", "<Plug>AirlineSelectTab3")
  keymap("n", "<A-4>", "<Plug>AirlineSelectTab4")
  keymap("n", "<A-5>", "<Plug>AirlineSelectTab5")
  keymap("n", "<A-6>", "<Plug>AirlineSelectTab6")
  keymap("n", "<A-7>", "<Plug>AirlineSelectTab7")
  keymap("n", "<A-8>", "<Plug>AirlineSelectTab8")
  keymap("n", "<A-9>", "<Plug>AirlineSelectTab9")

  vim.cmd [[
  function! AirlineInit()
      call airline#parts#define_raw('linenr', '☰ %l')
      let g:airline_section_z = airline#section#create(['%3p%% ', 'linenr', ':%c'])
  endfunction
  autocmd User AirlineAfterInit call AirlineInit()
  ]]
  -- }}}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
