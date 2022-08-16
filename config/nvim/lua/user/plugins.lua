-- Automatically install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
    install_path })
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

local ok, packer = pcall(require, "packer")
if not ok then
  return
end

-- recompile packer on when plugins.lua is saved
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "plugins.lua",
  callback = function()
    vim.cmd [[source <afile>]]
    packer.compile()
  end
})

-- Install plugins
packer.startup({ function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins

  use 'lewis6991/impatient.nvim' -- Caching for faster startup time
  use "famiu/bufdelete.nvim" -- Better buffer deletion
  use "farmergreg/vim-lastplace" -- Restore last cursor position
  use "konfekt/vim-sentence-chopper" -- Semantic Line Breaks
  use "michaeljsmith/vim-indent-object" -- Text objects based on indent level
  use "sickill/vim-pasta" -- Adjust indentation when pasting
  use "tpope/vim-eunuch" -- Helpers for UNIX
  use "tpope/vim-repeat" -- Repeat more things with "."
  use "tpope/vim-sleuth" -- Heuristically set buffer options
  use "tpope/vim-surround" -- Mappings for quotes, brackets, etc
  use "tpope/vim-unimpaired" -- Pairs of handy bracket mappings
  use "tpope/vim-vinegar" -- Improvements to netrw
  use "kyazdani42/nvim-web-devicons"

  use { -- Git related plugins
    { -- Git integration for buffers.
      -- gitsigns is configured to lazy load when in a git repo.
      -- Most other git related plugins then load after gitsigns.
      "lewis6991/gitsigns.nvim",
      opt = true,
      setup = function() require("user.git").gitsigns.setup() end,
      config = function() require("user.git").gitsigns.config() end,
    },
    { "junegunn/gv.vim", after = "gitsigns.nvim" }, -- Git commit browser
    { "tpope/vim-git", after = "gitsigns.nvim" }, -- Vim runtime files for git
    { "tpope/vim-fugitive", after = "gitsigns.nvim" }, -- Vim interface to git
    { "tpope/vim-rhubarb", after = "gitsigns.nvim" }, -- GitHub support for vim-fugitive
    {
      "ruifm/gitlinker.nvim", -- Shareable permalinks to git hosts
      keys = "<leader>gy",
      config = function()
        require("gitlinker").setup()
      end,
    },
    {
      "rhysd/committia.vim",
      after = "gitsigns.nvim",
      config = function() require("user.git").committia.config() end,
    },
  }

  use {
    "github/copilot.vim",
    config = function()
      -- disable copilot completion, since we'll use it through nvim-cmp
      vim.g.copilot_filetypes = { ["*"] = false }
    end
  }

  -- Dark colorscheme
  use { "willnorris/onedark.vim", branch = "lua" }

  -- Copy text to clipboard with OSC52
  use {
    "ojroques/nvim-osc52",
    config = function()
      local osc52 = require("osc52")
      osc52.setup { silent = true }

      vim.keymap.set("v", "Y", osc52.copy_visual)
      vim.keymap.set("n", "Y", osc52.copy_operator, { expr = true })

      -- use osc52 as clipboard provider
      -- https://github.com/ojroques/nvim-osc52#using-nvim-osc52-as-clipboard-provider
      local function copy(lines, _) osc52.copy(table.concat(lines, "\n")) end

      local function paste() return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') } end

      vim.g.clipboard = {
        name = "osc52",
        copy = { ["+"] = copy, ["*"] = copy },
        paste = { ["+"] = paste, ["*"] = paste },
      }
    end,
  }

  -- Toggle, display, and navigate marks
  use {
    "kshenoy/vim-signature",
    config = function()
      vim.keymap.set("n", "yom", "<Cmd>SignatureToggle<CR>", { desc = "toggle signs/marks" })
    end,
  }

  -- Smart and powerful commenting plugin
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

  -- Undo history visualizer
  use {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>u", "<Cmd>UndotreeToggle<CR>")
    end,
  }

  -- Auto-resize windows according to golden ratio
  use {
    "beauwilliams/focus.nvim",
    commit = "05df9ee",
    config = function()
      require "focus".setup {
        excluded_filetypes = { "fugitive", "gitcommit", "packer", "Outline" },
        signcolumn = false,
      }
      vim.keymap.set("n", "yogv", "<Cmd>FocusToggle<CR>", { desc = "toggle golden ratio view" })
    end,
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = '<Cmd>TSUpdate',
    config = function()
      require "nvim-treesitter.configs".setup {
        ensure_installed = { "go", "typescript" },
        auto_install = true,
        highlight = {
          enable = true,
          disable = function(_, bufnr)
            -- treesitter highlighting seems to have trouble with large files. Partially disussed
            -- (but not really resolved) at https://github.com/nvim-treesitter/nvim-treesitter/issues/556
            return vim.api.nvim_buf_line_count(bufnr) > 5000
          end,
        },
      }
    end,
  }
  use {
    "nvim-treesitter/nvim-treesitter-context",
    after = "nvim-treesitter",
    config = function()
      require "treesitter-context".setup { mode = "topline" }
    end
  }
  use {
    "lewis6991/spellsitter.nvim",
    config = function()
      require "spellsitter".setup()
    end
  }

  use {
    "https://github.com/RRethy/vim-illuminate",
    config = function()
      local illuminate = require "illuminate"
      vim.keymap.set('n', '<a-n>', function() illuminate.next_reference { wrap = true } end)
      vim.keymap.set('n', '<a-p>', function() illuminate.next_reference { reverse = true, wrap = true } end)
    end
  }

  -- Distraction-free writing and coding
  use {
    "folke/zen-mode.nvim",
    requires = {
      "benstockil/twilight.nvim", -- dim inactive portions of file
    },
    config = function()
      require "zen-mode".setup {
        window = {
          options = {
            signcolumn = "no",
            number = false,
          },
        },
      }
      vim.keymap.set("n", "<leader>zz", "<Cmd>ZenMode<CR>", { desc = "zen mode" })
    end,
  }

  -- Statusline
  use {
    "nvim-lualine/lualine.nvim",
    config = function() require("user.lualine") end,
  }

  -- File outline based on LSP symbols
  use {
    "simrat39/symbols-outline.nvim",
    after = "nvim-lspconfig",
    config = function()
      vim.g.symbols_outline = {
        auto_preview = false,
      }
      vim.keymap.set("n", "<leader>o", "<Cmd>SymbolsOutline<CR>", { desc = "symbol outline" })
    end,
  }

  use {
    "stevearc/stickybuf.nvim",
    config = function()
      require("stickybuf").setup {
        filetype = {
          Outline = "filetype",
        },
      }
    end,
  }

  use {
    "hrsh7th/nvim-cmp",
    requires = {
      -- Completion plugins
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-copilot",
      "f3fora/cmp-spell",

      -- Snippets
      "L3MON4D3/LuaSnip", -- Snippet engine
      "rafamadriz/friendly-snippets", -- A bunch of snippets to use
    },
    config = function() require("user.cmp") end
  }

  -- LSP
  use {
    {
      "neovim/nvim-lspconfig",
      ft = { "go", "html", "lua", "typescript" },
      module = "lspconfig",
      config = function() require("user.lsp") end,
    },
    { "williamboman/nvim-lsp-installer", module = "nvim-lsp-installer" },
    { "jose-elias-alvarez/null-ls.nvim", module = "null-ls" },
    { "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim", module = "toggle_lsp_diagnostics" },
    {
      "rmagatti/goto-preview",
      module = "goto-preview",
      config = function() require("goto-preview").setup() end,
    }
  }

  -- Telescope
  use {
    {
      "nvim-telescope/telescope.nvim",
      module = "telescope",
      cmd = "Telescope",
      keys = require("user.telescope").keys,
      config = function() require("user.telescope").config() end,
    },
    { "nvim-telescope/telescope-file-browser.nvim", module = "telescope._extensions.file_browser", },
    {
      "stevearc/dressing.nvim",
      module = "dressing",
      config = function()
        require("dressing").setup {
          input = {
            anchor = "NW",
            winblend = 0,
          },
          select = {
            telescope = require('telescope.themes').get_cursor(),
          },
        }
      end
    }
  }

  -- Diagnostics viewer
  use {
    "folke/trouble.nvim",
    config = function() require("user.trouble") end
  }

  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        highlight = {
          pattern = {
            [[.*<(KEYWORDS)\s*:]],
            [[.*<(KEYWORDS)\(.*\)\s*:]], -- handle KEYWORD(name):
          },
          keyword = "fg",
          after = "",
        },
        search = {
          pattern = [[\b(KEYWORDS)(\(.*\))?:]],
        },
      }
    end
  }

  use {
    "stevearc/qf_helper.nvim",
    config = function()
      require('qf_helper').setup {
        quickfix = {
          default_bindings = false,
        },
      }
    end,
  }

  use {
    "https://github.com/folke/which-key.nvim",
    config = function()
      require "which-key".setup {
        icons = {
          separator = "",
        },
        window = {
          border = "single",
        },
      }
    end,
  }

  use {
    "nvim-neotest/neotest",
    opt = true,
    keys = require("user.neotest").keys,
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      { "nvim-neotest/neotest-go", module = "neotest-go" },
      { "nvim-neotest/neotest-python", module = "neotest-python" },
    },
    config = function() require("user.neotest").config() end,
  }

  use {
    "lewis6991/cleanfold.nvim",
    config = function()
      require("cleanfold").setup()
    end
  }


  -- TODO: look at https://github.com/mfussenegger/nvim-dap

  -- Automatically set up configuration after cloning packer.nvim
  if packer_bootstrap then
    require("packer").sync()
  end
end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'rounded' })
      end
    }
  },
})
