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
    keys = {
      { "Y", function() require("osc52").copy_operator() end, { expr = true } },
      { "Y", function() require("osc52").copy_visual() end, mode="v" },
    },
    init = function()
      -- use osc52 as clipboard provider
      -- https://github.com/ojroques/nvim-osc52#using-nvim-osc52-as-clipboard-provider
      local function copy(lines, _)
        require("osc52").copy(table.concat(lines, "\n"))
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
    opt = { silent = true },
  },

  -- Toggle, display, and navigate marks
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    config = true,
  },

  {
    "editorconfig/editorconfig-vim",
    event = "VeryLazy",
    config = function()
      vim.g.EditorConfig_exclude_patterns = { "fugitive://.*" }
    end,
  },

  -- Undo history visualizer
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", "<Cmd>UndotreeToggle<CR>" },
    },
  },

  -- Auto-resize windows according to golden ratio
  {
    "beauwilliams/focus.nvim",
    event = "VimEnter",
    keys = {
      { "yogv", "<Cmd>FocusToggle<CR>", desc = "toggle golden ratio view" }
    },
    opts = {
      excluded_filetypes = { "fugitive", "gitcommit", "packer", "Outline" },
      signcolumn = false,
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-context", opts = { mode = "topline" } },
    },
    opts = function(_, opts)
      opts.ensure_installed[#opts.ensure_installed + 1] = "go"

      return vim.tbl_deep_extend("force", opts, {
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
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = { mode = "topline" },
  },

  {
    "nvim-orgmode/orgmode",
    opts = {
      org_agenda_files = "~/.local/share/orgmode/*",
      org_default_notes_file = "~/.local/share/orgmode/notes.org",
    },
    config = function(_, opts)
      require("orgmode").setup_ts_grammar()
      require("orgmode").setup(opts)
    end,
  },

  {
    "stevearc/stickybuf.nvim",
    opts = {
      filetype = {
        Outline = "filetype",
      },
    }
  },

  {
    "stevearc/qf_helper.nvim",
    opts = {
      quickfix = {
        default_bindings = false,
      },
    }
  },

  {
    "lewis6991/cleanfold.nvim",
    config = true,
  },
}
