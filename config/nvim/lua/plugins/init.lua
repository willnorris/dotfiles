return {
  "konfekt/vim-sentence-chopper", -- Semantic Line Breaks
  "michaeljsmith/vim-indent-object", -- Text objects based on indent level
  "sickill/vim-pasta", -- Adjust indentation when pasting
  "tpope/vim-eunuch", -- Helpers for UNIX
  "tpope/vim-sleuth", -- Heuristically set buffer options
  "tpope/vim-unimpaired", -- Pairs of handy bracket mappings
  "isobit/vim-caddyfile", -- Caddyfile syntax support

  { "echasnovski/mini.pairs", enabled = false },
  { "folke/tokyonight.nvim",  enabled = false },
  { "catppuccin/nvim",        name = "catppuccin", enabled = false },

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
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-context", opts = { mode = "topline" } },
    },
    opts = function(_, opts)
      opts.ensure_installed[#opts.ensure_installed + 1] = "go"

      return vim.tbl_deep_extend("keep", {
        auto_install = true,
        highlight = {
          enable = true,
          disable = function(_, bufnr)
            -- treesitter highlighting seems to have trouble with large files. Partially disussed
            -- (but not really resolved) at https://github.com/nvim-treesitter/nvim-treesitter/issues/556
            return vim.api.nvim_buf_line_count(bufnr) > 100000
          end,
        },
        incremental_selection = {
          enable = true,
          -- I don't love these default keymaps, but <c-space> from LazyVim conflicts with my tmux config
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      }, opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({ mode = "topline" })
    end,
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
    "lewis6991/cleanfold.nvim",
    config = function()
      require("cleanfold").setup()
    end,
  },
}
