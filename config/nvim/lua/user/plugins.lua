-- Automatically install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
    install_path })
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Reload neovim config when plugins.lua file is saved
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local ok, packer = pcall(require, "packer")
if not ok then
  return
end

-- Install plugins
return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins

  use "google/vim-jsonnet"
  use "joshdick/onedark.vim"
  use "junegunn/gv.vim"
  use "konfekt/vim-sentence-chopper"
  use "kshenoy/vim-signature"
  use "michaeljsmith/vim-indent-object"
  use "sheerun/vim-polyglot"
  use "sickill/vim-pasta"
  use "tpope/vim-afterimage"
  use "tpope/vim-eunuch"
  use "tpope/vim-fugitive"
  use "tpope/vim-git"
  use "tpope/vim-repeat"
  use "tpope/vim-sensible"
  use "tpope/vim-sleuth"
  use "tpope/vim-surround"
  use "tpope/vim-unimpaired"
  use "tpope/vim-vinegar"

  use {
    "fatih/vim-go",
    config = function()
      vim.g.go_def_mapping_enabled = false
    end,
  }

  use {
    "moll/vim-bbye",
    config = function()
      vim.keymap.set("n", "<C-q>", "<Cmd>Bdelete<CR>")
    end,
  }

  use {
    "ojroques/vim-oscyank",
    config = function()
      vim.keymap.set("v", "<C-c>", "<Cmd>OSCYank<cr>")
    end,
  }

  use {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end
  }

  use {
    "editorconfig/editorconfig-vim",
    config = function()
      vim.g.EditorConfig_exclude_patterns = { "fugitive://.*" }
    end,
  }

  use {
    "sjl/gundo.vim",
    config = function()
      vim.g.gundo_preview_bottom = 1
      vim.g.gundo_prefer_python3 = 1
      vim.keymap.set("n", "<leader>u", "<Cmd>GundoToggle<CR>")
    end,
  }

  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {
        signs = {
          add = { text = "+" },
          change = { text = "~" },
        }
      }
      vim.keymap.set("n", "yogs", "<Cmd>Gitsigns toggle_signs<CR>")
    end,
  }

  use {
    "beauwilliams/focus.nvim",
    config = function()
      require "focus".setup {
      }
      vim.keymap.set("n", "yogv", "<Cmd>FocusToggle<CR>")
    end,
  }

  use {
    "mileszs/ack.vim",
    config = function()
      if vim.fn.executable("rg") == 1 then
        vim.opt.grepprg = "rg --vimgrep --no-heading"
        vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
        vim.g.ackprg = "rg --vimgrep --no-heading"
      end
      vim.keymap.set("n", "<leader>a", "<Cmd>Ack! ")
    end,
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = '<Cmd>TSUpdate'
  }

  use {
    "folke/zen-mode.nvim",
    config = function()
      require "zen-mode".setup {
        window = {
          options = {
            signcolumn = "no",
            number = false,
          },
        },
      }
      vim.keymap.set("n", "<leader>zz", "<Cmd>ZenMode<CR>")
    end,
  }

  use {
    "benstockil/twilight.nvim",
    config = function()
      require("twilight").setup {}
      vim.cmd [[highlight Twilight ctermfg=8]]
    end,
  }

  use {
    "nvim-lualine/lualine.nvim",
    config = function()
      -- customize 16color theme, swapping insert and normal color
      local t16c = require "lualine.themes.16color"
      local normal = t16c.normal.a
      t16c.normal.a = t16c.insert.a
      t16c.insert.a = normal
      t16c.normal.a.fg = "#000000"
      t16c.insert.a.fg = "#000000"
      t16c.visual.a.fg = "#000000"

      require("lualine").setup {
        options = {
          theme = t16c,
          icons_enabled = false,
          section_separators = "",
          component_separators = "",
        },
        sections = {
          lualine_a = {
            { "mode", fmt = function(str) return str:sub(1, 1) end }
          },
        },
        tabline = {
          lualine_a = { { "buffers", mode = 2 } },
          lualine_z = { { "tabs", mode = 2 } },
        }
      }
    end,
  }

  use {
    'preservim/nerdtree',
    config = function()
      vim.g.NERDTreeMapOpenVSPlit = "v"
      vim.keymap.set("n", "<leader>ff", "<Cmd>NERDTreeToggle<CR>")

      -- Close the tab if NERDTree is the only window remaining in it.
      vim.cmd [[autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif]]
      -- If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
      vim.cmd [[autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
        \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif]]
    end,
  }

  use {
    "simrat39/symbols-outline.nvim",
    config = function()
      vim.g.symbols_outline = {
        auto_preview = false,
        show_symbol_details = false,
        symbols = {
          Field = { icon = "f" },
          Function = { icon = "ƒ" },
          Struct = { icon = "s" },
        }
      }
      vim.keymap.set("n", "<leader>tt", "<Cmd>SymbolsOutline<CR>")
    end,
  }

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-nvim-lsp-signature-help"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"

  -- Telescope
  use "nvim-telescope/telescope.nvim"

  use {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
        icons = false,
        fold_open = "▾",
        fold_closed = "▸",
        indent_lines = false,
        use_diagnostic_signs = true,
      }
      vim.keymap.set("n", "<leader>xx", "<Cmd>TroubleToggle<CR>")
    end
  }

  -- Automatically set up configuration after cloning packer.nvim
  if packer_bootstrap then
    require("packer").sync()
  end
end)
