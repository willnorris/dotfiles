return {
  "nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins

  "famiu/bufdelete.nvim", -- Better buffer deletion
  "farmergreg/vim-lastplace", -- Restore last cursor position
  "konfekt/vim-sentence-chopper", -- Semantic Line Breaks
  "michaeljsmith/vim-indent-object", -- Text objects based on indent level
  "sickill/vim-pasta", -- Adjust indentation when pasting
  "tpope/vim-eunuch", -- Helpers for UNIX
  "tpope/vim-repeat", -- Repeat more things with ".",
  "tpope/vim-sleuth", -- Heuristically set buffer options
  "tpope/vim-surround", -- Mappings for quotes, brackets, etc
  "tpope/vim-unimpaired", -- Pairs of handy bracket mappings
  "tpope/vim-vinegar", -- Improvements to netrw
  "nvim-tree/nvim-web-devicons",
  "isobit/vim-caddyfile", -- Caddyfile syntax support

  { "folke/noice.nvim",                    enabled = false },
  { "echasnovski/mini.pairs",              enabled = false },
  { "bufferline.nvim",                     enabled = false },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },


  { -- Git related plugins
    { -- Git integration for buffers.
      -- gitsigns is configured to lazy load when in a git repo.
      -- Most other git related plugins then load after gitsigns.
      "lewis6991/gitsigns.nvim",
      opt = true,
      build = function()
        require("config.git").gitsigns.setup()
      end,
      config = function()
        require("config.git").gitsigns.config()
      end,
    },
    "junegunn/gv.vim", -- Git commit browser
    "tpope/vim-git", -- Vim runtime files for git
    "tpope/vim-fugitive", -- Vim interface to git
    "tpope/vim-rhubarb", -- GitHub support for vim-fugitive
    "rhysd/git-messenger.vim", -- commit message under cursor
    {
      "ruifm/gitlinker.nvim", -- Shareable permalinks to git hosts
      keys = "<leader>gy",
      config = function()
        require("gitlinker").setup()
      end,
    },
    {
      "rhysd/committia.vim",
      config = function()
        require("config.git").committia.config()
      end,
    },
  },

  -- Copy text to clipboard with OSC52
  {
    "ojroques/nvim-osc52",
    config = function()
      local osc52 = require("osc52")
      osc52.setup({ silent = true })

      vim.keymap.set("v", "Y", osc52.copy_visual)
      vim.keymap.set("n", "Y", osc52.copy_operator, { expr = true })

      -- use osc52 as clipboard provider
      -- https://github.com/ojroques/nvim-osc52#using-nvim-osc52-as-clipboard-provider
      local function copy(lines, _)
        osc52.copy(table.concat(lines, "\n"))
      end

      local function paste()
        return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
      end

      vim.g.clipboard = {
        name = "osc52",
        copy = { ["+"] = copy,["*"] = copy },
        paste = { ["+"] = paste,["*"] = paste },
      }
    end,
  },

  -- Toggle, display, and navigate marks
  {
    "kshenoy/vim-signature",
    config = function()
      vim.keymap.set("n", "yom", "<Cmd>SignatureToggle<CR>", { desc = "toggle signs/marks" })
    end,
  },

  -- Smart and powerful commenting plugin
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "editorconfig/editorconfig-vim",
    config = function()
      vim.g.EditorConfig_exclude_patterns = { "fugitive://.*" }
    end,
  },

  -- Undo history visualizer
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>u", "<Cmd>UndotreeToggle<CR>")
    end,
  },

  -- Auto-resize windows according to golden ratio
  {
    "beauwilliams/focus.nvim",
    commit = "05df9ee",
    config = function()
      require("focus").setup({
        excluded_filetypes = { "fugitive", "gitcommit", "packer", "Outline" },
        signcolumn = false,
      })
      vim.keymap.set("n", "yogv", "<Cmd>FocusToggle<CR>", { desc = "toggle golden ratio view" })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      pcall(require("nvim-treesitter.install").update({ with_sync = true }))
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("config.treesitter")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({ mode = "topline" })
    end,
  },

  {
    { "rcarriga/nvim-dap-ui",            module = "dapui" },
    { "leoluz/nvim-dap-go",              module = "dap-go" },
    { "theHamsta/nvim-dap-virtual-text", module = "nvim-dap-virtual-text" },
    {
      "mfussenegger/nvim-dap",
      opt = true,
      keys = "<leader>d",
      module = "dap",
      config = function()
        local dap, dapui = require("dap"), require("dapui")
        dapui.setup()
        require("dap-go").setup()
        require("nvim-dap-virtual-text").setup({
          commented = true,
        })

        vim.keymap.set("n", "<leader>dd", dapui.toggle, { desc = "debug: toggle UI" })
        vim.keymap.set("n", "<leader>dk", dap.continue, { desc = "debug: continue" })
        vim.keymap.set("n", "<leader>dj", dap.step_over, { desc = "debug: step over" })
        vim.keymap.set("n", "<leader>dl", dap.step_into, { desc = "debug: step into" })
        vim.keymap.set("n", "<leader>dh", dap.step_out, { desc = "debug: step out" })
        vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "debug: run last" })
        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "debug: toggle breakpoint" })
        vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "debug: terminate session" })
      end,
    },
  },

  {
    "nvim-orgmode/orgmode",
    config = function()
      require("orgmode").setup_ts_grammar()
      require("orgmode").setup({
        org_agenda_files = "~/.local/share/orgmode/*",
        org_default_notes_file = "~/.local/share/orgmode/notes.org",
      })
    end,
  },

  {
    "RRethy/vim-illuminate",
    keys = {
      { "<c-n>", require("illuminate").goto_next_reference, desc = "Next reference" },
      { "<c-p>", require("illuminate").goto_prev_reference, desc = "Prev reference" },
    },
  },

  -- Distraction-free writing and coding
  {
    "folke/zen-mode.nvim",
    opt = true,
    keys = "<leader>zz",
    dependencies = {
      "benstockil/twilight.nvim", -- dim inactive portions of file
    },
    config = function()
      require("zen-mode").setup({
        window = {
          options = {
            signcolumn = "no",
            number = false,
          },
        },
      })
      vim.keymap.set("n", "<leader>zz", "<Cmd>ZenMode<CR>", { desc = "zen mode" })
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("config.lualine")
    end,
  },

  {
    "stevearc/stickybuf.nvim",
    config = function()
      require("stickybuf").setup({
        filetype = {
          Outline = "filetype",
        },
      })
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    dependencies = {
      "zbirenbaum/copilot-cmp",
    },
    event = "VimEnter",
    config = function()
      vim.defer_fn(function()
        require("copilot").setup({
          filetypes = {
            ["dap-repl"] = false,
          },
        })
        require("copilot_cmp").setup()
      end, 100)
    end,
  },

  { -- Text Completion
    {
      "hrsh7th/nvim-cmp",
      opt = true,
      event = "InsertEnter",
      dependencies = {
        -- Completion plugins
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "zbirenbaum/copilot-cmp",
        "f3fora/cmp-spell",
      },
      config = function()
        require("config.cmp")
      end,
    },
    { "L3MON4D3/LuaSnip",            module = "luasnip" },
    { "rafamadriz/friendly-snippets" },
  },

  -- Telescope
  {
    {
      "nvim-telescope/telescope.nvim",
      module = "telescope",
      cmd = "Telescope",
      keys = require("config.telescope").keys,
      config = function()
        require("config.telescope").config()
      end,
    },
    { "nvim-telescope/telescope-file-browser.nvim", module = "telescope._extensions.file_browser" },
    {
      "stevearc/dressing.nvim",
      module = "dressing",
      config = function()
        require("dressing").setup({
          input = {
            anchor = "NW",
            win_options = {
              winblend = 0,
            },
          },
          select = {
            telescope = require("telescope.themes").get_cursor(),
          },
        })
      end,
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = "plenary.nvim",
    config = function()
      require("todo-comments").setup({
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
      })
    end,
  },

  {
    "stevearc/qf_helper.nvim",
    config = function()
      require("qf_helper").setup({
        quickfix = {
          default_bindings = false,
        },
      })
    end,
  },

  {
    "folke/which-key.nvim",
    module = "which-key",
    config = function()
      require("which-key").setup({
        icons = {
          separator = "",
        },
        window = {
          border = "single",
        },
      })
    end,
  },

  {
    "nvim-neotest/neotest",
    opt = true,
    keys = require("config.neotest").keys,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      { "nvim-neotest/neotest-go",     module = "neotest-go" },
      { "nvim-neotest/neotest-python", module = "neotest-python" },
    },
    config = function()
      require("config.neotest").config()
    end,
  },

  {
    "lewis6991/cleanfold.nvim",
    config = function()
      require("cleanfold").setup()
    end,
  },
}
