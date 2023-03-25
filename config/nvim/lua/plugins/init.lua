return {
  "konfekt/vim-sentence-chopper", -- Semantic Line Breaks
  "michaeljsmith/vim-indent-object", -- Text objects based on indent level
  "sickill/vim-pasta", -- Adjust indentation when pasting
  "tpope/vim-eunuch", -- Helpers for UNIX
  "tpope/vim-sleuth", -- Heuristically set buffer options
  "tpope/vim-unimpaired", -- Pairs of handy bracket mappings
  "isobit/vim-caddyfile", -- Caddyfile syntax support

  { "echasnovski/mini.pairs", enabled = false },
  { "folke/tokyonight.nvim", enabled = false },
  { "catppuccin/nvim", name = "catppuccin", enabled = false },

  -- Copy text to clipboard with OSC52
  {
    "ojroques/nvim-osc52",
    keys = {
      { "Y", function() require("osc52").copy_operator() end, { expr = true } },
      { "Y", function() require("osc52").copy_visual() end, mode = "v" },
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
    opts = { silent = true },
  },

  -- Toggle, display, and navigate marks
  {
    "chentoast/marks.nvim",
    keys = {
      { "yom", "<cmd>MarksToggleSigns<cr>", desc = "Toggle marks" },
    },
    event = "VeryLazy",
    config = true,
  },

  -- Undo history visualizer
  {
    "mbbill/undotree",
    keys = {
      { "<leader>uu", "<Cmd>UndotreeToggle<CR>", desc = "Toggle undo tree" },
    },
  },

  -- Auto-resize windows according to golden ratio
  {
    "beauwilliams/focus.nvim",
    event = "VimEnter",
    keys = {
      { "yogv", "<Cmd>FocusToggle<CR>", desc = "toggle golden ratio view" }
    },
    opts = function(_, opts)
      opts.excluded_filetypes = opts.excluded_filetypes or {}
      vim.list_extend(opts.excluded_filetypes, { "fugitive", "gitcommit", "Outline" })
      opts.signcolumn = false
      return opts
    end,
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
      get_auto_pin = function(buf)
        if vim.bo[buf].filetype == "Outline" then
          return "filetype"
        end
      end,
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

  {
    "max397574/better-escape.nvim",
    opts = {
      mapping = { "jk" },
    },
  },
}
