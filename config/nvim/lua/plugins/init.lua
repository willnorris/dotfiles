return {
  "konfekt/vim-sentence-chopper",    -- Semantic Line Breaks
  "michaeljsmith/vim-indent-object", -- Text objects based on indent level
  "tpope/vim-sleuth",                -- Heuristically set buffer options
  "isobit/vim-caddyfile",            -- Caddyfile syntax support

  { "echasnovski/mini.bracketed", config = true },
  { "echasnovski/mini.pairs", enabled = false },
  { "folke/tokyonight.nvim", enabled = false },
  { "catppuccin/nvim", name = "catppuccin", enabled = false },

  -- Copy text to clipboard with OSC52
  {
    "ojroques/nvim-osc52",
    keys = {
      { "Y", function() require("osc52").copy_operator() end, expr = true, desc = "Yank to clipboard" },
      { "Y", function() require("osc52").copy_visual() end, mode = "v", desc = "Yank to clipboard" },
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
        copy = { ["+"] = copy, ["*"] = copy },
        paste = { ["+"] = paste, ["*"] = paste },
      }
    end,
    opts = { silent = true },
  },

  -- Toggle, display, and navigate marks
  {
    "chentoast/marks.nvim",
    keys = {
      { "<leader>um", "<cmd>MarksToggleSigns<cr>", desc = "Toggle marks" },
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
    "nvim-focus/focus.nvim",
    branch = "refactor",
    event = "VimEnter",
    keys = {
      { "<leader>uv", function() require("focus").focus_toggle() end, desc = "Toggle golden ratio view" }
    },
    opts = {
      ui = {
        signcolumn = false,
      },
    },
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
    },
  },

  {
    "stevearc/qf_helper.nvim",
    opts = {
      quickfix = {
        default_bindings = false,
      },
    },
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
