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

-- Install plugins
packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins

  use "famiu/bufdelete.nvim" -- Better buffer deletion
  use "farmergreg/vim-lastplace" -- Restore last cursor position
  use "junegunn/gv.vim" -- Git commit browser
  use "konfekt/vim-sentence-chopper" -- Semantic Line Breaks
  use "michaeljsmith/vim-indent-object" -- Text objects based on indent level
  use "sickill/vim-pasta" -- Adjust indentation when pasting
  use "tpope/vim-eunuch" -- Helpers for UNIX
  use "tpope/vim-fugitive" -- Vim interface to git
  use "tpope/vim-rhubarb" -- GitHub support for vim-fugitive
  use "tpope/vim-git" -- Vim runtime files for git
  use "tpope/vim-repeat" -- Repeat more things with "."
  use "tpope/vim-sleuth" -- Heuristically set buffer options
  use "tpope/vim-surround" -- Mappings for quotes, brackets, etc
  use "tpope/vim-unimpaired" -- Pairs of handy bracket mappings
  use "kyazdani42/nvim-web-devicons"

  use {
    "github/copilot.vim",
    config = function ()
      -- disable copilot completion, since we'll use it through nvim-cmp
      vim.g.copilot_filetypes = {}
      vim.g.copilot_filetypes["*"] = false
    end
  }

  -- Dark colorscheme
  use {
    "willnorris/onedark.vim",
    branch = "lua",
  }

  -- Copy text to clipboard with OSC52
  use {
    "ojroques/vim-oscyank",
    config = function()
      -- Y yanks to client clipboard (must use : rather than <Cmd>)
      vim.keymap.set("v", "Y", ":OSCYank<CR>")
      vim.keymap.set("n", "Y", "<Plug>OSCYank")

      -- use OSCYank to integrate with client clipboard
      -- https://github.com/ojroques/vim-oscyank/issues/24#issuecomment-1098406019
      local function copy(lines, _) vim.fn.OSCYankString(table.concat(lines, "\n")) end
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

  -- Git integration for buffers
  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {
        signs = {
          add = { text = "+" },
          change = { text = "~" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          vim.keymap.set('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true, buffer = bufnr })

          vim.keymap.set('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true, buffer = bufnr })

          vim.keymap.set("n", "yogs", gs.toggle_signs, { desc = "toggle git signs" })
          vim.keymap.set("n", "<leader>ga", gs.stage_hunk, { desc = "git add hunk" })
          vim.keymap.set("n", "<leader>gu", gs.undo_stage_hunk, { desc = "undo add hunk" })
          vim.keymap.set("n", "<leader>gr", gs.reset_hunk, { desc = "git reset hunk" })
          vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { desc = "git preview hunk" })
        end,
      }
      vim.keymap.set("n", "yogs", "<Cmd>Gitsigns toggle_signs<CR>")
    end,
  }

  -- Auto-resize windows according to golden ratio
  use {
    "beauwilliams/focus.nvim",
    config = function()
      require "focus".setup {
      }
      vim.keymap.set("n", "yogv", "<Cmd>FocusToggle<CR>")
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
        },
      }
    end,
  }
  use {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require "treesitter-context".setup { mode = "topline" }
    end
  }

  -- Distraction-free writing and coding
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

  -- Dim inactive portions of file content
  use {
    "benstockil/twilight.nvim",
    config = function()
      require("twilight").setup {}
      vim.cmd [[highlight Twilight ctermfg=8]]
    end,
  }

  -- Statusline
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
          lualine_c = {
            { "filename", color = { fg = "white" } },
            function()
              return require('nvim-treesitter').statusline({
                separator = " > ",
              })
            end,
          },
        },
        tabline = {
          lualine_a = { { "buffers", mode = 2 } },
          lualine_z = { { "tabs", mode = 2 } },
        }
      }
    end,
  }

  -- File tree explorer
  use {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        renderer = {
          indent_markers = {
            enable = true,
          },
        },
      })
      vim.keymap.set("n", "<leader>ff", "<Cmd>NvimTreeFindFile<CR>")
      vim.keymap.set("n", "<leader>ft", "<Cmd>NvimTreeToggle<CR>")

      vim.cmd [[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]]
    end,
  }

  -- File outline based on LSP symbols
  use {
    "simrat39/symbols-outline.nvim",
    config = function()
      vim.g.symbols_outline = {
        auto_preview = false,
      }
      vim.keymap.set("n", "<leader>o", "<Cmd>SymbolsOutline<CR>")
    end,
  }

  -- Completion plugins
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/cmp-buffer" }, -- Buffer completions
      { "hrsh7th/cmp-path" }, -- Path completions
      { "saadparwaiz1/cmp_luasnip" }, -- Snippet completions
      { "hrsh7th/cmp-nvim-lsp" }, -- LSP completions
      { "hrsh7th/cmp-nvim-lua" }, -- Lua completions
      { "hrsh7th/cmp-nvim-lsp-signature-help" }, -- LSP function signature completions
      { "hrsh7th/cmp-copilot" }, -- LSP function signature completions
    },
    config = function()
      require("user.cmp")
    end
  }

  -- Snippets
  use "L3MON4D3/LuaSnip" -- Snippet engine
  use "rafamadriz/friendly-snippets" -- A bunch of snippets to use

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    requires = {
      "williamboman/nvim-lsp-installer",
    },
    config = function()
      require("user.lsp")
    end,
  }

  -- Null-LS
  use {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup {
        sources = {
          null_ls.builtins.code_actions.gitsigns,
          null_ls.builtins.code_actions.shellcheck,
          null_ls.builtins.diagnostics.shellcheck,
        }
      }
    end
  }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      'nvim-telescope/telescope-ui-select.nvim'
    },
    config = function()
      require("user.telescope")

      local tb = require("telescope.builtin")
      vim.keymap.set("n", "<C-t>", tb.find_files, { desc = "search files" })
      vim.keymap.set("n", "<leader>sf", tb.find_files, { desc = "search files" })
      vim.keymap.set("n", "<leader>sb", tb.buffers, { desc = "search buffers" })
      vim.keymap.set("n", "<leader>ss", tb.live_grep, { desc = "search for string" })
      vim.keymap.set("n", "<leader>sc", tb.grep_string, { desc = "search for string under cursor" })
      vim.keymap.set("n", "<leader>sh", tb.highlights, { desc = "search highlights" })
      vim.keymap.set("n", "<leader>sd", tb.diagnostics, { desc = "search diagnostics" })
      vim.keymap.set("n", "<leader>so", tb.oldfiles, { desc = "search previous files" })
    end
  }

  -- Diagnostics viewer
  use {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
        fold_open = "",
        fold_closed = "",
        indent_lines = false,
        use_diagnostic_signs = true,
      }
      vim.keymap.set("n", "<leader>xx", "<Cmd>TroubleToggle<CR>")
      vim.keymap.set("n", "<leader>xw", "<Cmd>Trouble workspace_diagnostics<CR>")
      vim.keymap.set("n", "<leader>xd", "<Cmd>Trouble document_diagnostics<CR>")
      vim.keymap.set("n", "<leader>xl", "<Cmd>Trouble loclist<CR>")
      vim.keymap.set("n", "<leader>xq", "<Cmd>Trouble quickfix<CR>")
    end
  }

  -- Toggle LSP diagnostics
  use {
    "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
    config = function()
      require 'toggle_lsp_diagnostics'.init({
        update_in_insert = false,
      })
      vim.keymap.set("n", "yoxx", "<Plug>(toggle-lsp-diag-vtext)")
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
      }
    end,
  }

  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-python",
    },
    config = function()
      local neotest = require("neotest")
      neotest.setup {
        adapters = {
          require("neotest-go"),
          require("neotest-python"),
        },
        icons = {
          expanded = "┐",
          final_child_prefix = "└",
        },
        output = {
          open_on_run = false,
        }
      }

      vim.diagnostic.config({
        signs = true,
        virtual_text = true,
      }, vim.api.nvim_create_namespace("neotest"))

      vim.keymap.set("n", "<leader>tt", neotest.run.run, {desc="run nearest test"})
      vim.keymap.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, {desc="test file"})
      vim.keymap.set("n", "<leader>tl", neotest.run.run_last, {desc="run last test"})
      vim.keymap.set("n", "<leader>ts", neotest.summary.toggle, {desc="show test summary"})
      vim.keymap.set("n", "<leader>to", neotest.output.open, {desc="show test output"})
      vim.keymap.set("n", "<leader>tw", function()
        neotest.output.open({ open_win = function() vim.cmd("bel split") end })
      end, {desc="show test window"})
    end,
  }

  -- TODO: look at https://github.com/mfussenegger/nvim-dap

  -- Automatically set up configuration after cloning packer.nvim
  if packer_bootstrap then
    require("packer").sync()
  end
end)
