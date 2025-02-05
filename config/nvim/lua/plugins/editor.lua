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
    "folke/which-key.nvim",
    module = "which-key",
    opts = {
      preset = "classic",
      icons = {
        separator = "",
        mappings = false,
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

  {
    "zk-org/zk-nvim",
    config = function()
      require("zk").setup({
        picker = "fzf",
        lsp = {
          config = {
            cmd = { "zk", "lsp" },
            name = "zk",
          },
        },
      })
    end
  },

}
