return {
  {
    "konfekt/vim-sentence-chopper", -- Semantic Line Breaks
    keys = {
      -- e.g. `gsap` to format paragraph at semantic line breaks
      { "gs", "<plug>(ChopSentences)", mode = { "n", "x" }, desc = "Semantic Line Break" },
    },
  },
  { "tpope/vim-sleuth" }, -- Heuristically set buffer options

  {
    "max397574/better-escape.nvim",
    opts = {
      mappings = {
        -- disable "jj" mappings
        i = { j = { j = false } },
        c = { j = { j = false } },
        t = { j = { j = false } },
      },
    },
  },

  { -- Toggle, display, and navigate marks
    "chentoast/marks.nvim",
    keys = {
      { "<leader>um", "<cmd>MarksToggleSigns<cr>", desc = "Toggle marks" },
    },
    event = "VeryLazy",
    config = true,
  },

  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>gl", "<cmd>FzfLua git_bcommits<CR>", desc = "File Commits" },
    },
    opts = {
      winopts = { split = "botright new" },
      keymap = {
        builtin = {
          ["<c-d>"] = "half-page-down",
          ["<c-u>"] = "half-page-up",

          ["<m-j>"] = "preview-down",
          ["<m-k>"] = "preview-up",
          ["<m-d>"] = "preview-half-page-down",
          ["<m-u>"] = "preview-half-page-up",
          ["<m-f>"] = "preview-page-down",
          ["<m-b>"] = "preview-page-up",

          ["<c-o>"] = "toggle-preview",
        },
        fzf = {
          ["ctrl-d"] = "half-page-down",
          ["ctrl-u"] = "half-page-up",

          ["ctrl-o"] = "toggle-preview",
        },
      },
    },
  },

  {
    "folke/which-key.nvim",
    module = "which-key",
    opts = {
      preset = "classic",
      icons = {
        separator = "",
        rules = false,
      },
      win = {
        border = "rounded",
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = "plenary.nvim",
    opts = {
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
    },
  },

  {
    "folke/trouble.nvim",
    opts = {
      cycle_results = false,
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

  { -- Undo history visualizer
    "mbbill/undotree",
    keys = {
      { "<leader>uu", "<Cmd>UndotreeToggle<CR>", desc = "Toggle undo tree" },
    },
  },
}
