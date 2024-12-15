return {
  { import = "lazyvim.plugins.extras.ai.copilot" },

  { "echasnovski/mini.bracketed", config = true },
  { "echasnovski/mini.pairs", enabled = false },

  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "default",
        ["<c-j>"] = { "select_next", "fallback" },
        ["<c-k>"] = { "select_prev", "fallback" },
        ["<m-j>"] = { "scroll_documentation_down", "fallback" },
        ["<m-k>"] = { "scroll_documentation_up", "fallback" },
        ["<enter>"] = { "fallback" },
      },
      completion = {
        menu = {
          border = "rounded",
        },
        documentation = {
          window = {
            border = "rounded",
          },
        },
      },
    },
  },

  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "ys",     -- Add surrounding in Normal and Visual modes
        delete = "ds",  -- Delete surrounding
        replace = "cs", -- Replace surrounding
      },
    },
  },

  {
    { import = "lazyvim.plugins.extras.test.core" },
    {
      "nvim-neotest/neotest",
      opts = {
        icons = {
          failed = "",
          passed = "",
        },
      },
      keys = {
        { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last Test" },
      },
    },
  },

  {
    { import = "lazyvim.plugins.extras.dap.core" },
    {
      "jay-babu/mason-nvim-dap.nvim",
      opts = {
        handlers = {
          delve = function(config)
            config.adapters.executable.args =
                vim.list_extend(config.adapters.executable.args, { "--check-go-version=false" })
            config.configurations = vim.list_extend(config.configurations or {}, {
              {
                type = "delve",
                name = "Delve: Attach",
                mode = "local",
                request = "attach",
                processId = require("dap.utils").pick_process,
              },
            })
            require("mason-nvim-dap").default_setup(config)
          end,
        },
      },
    },
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    keys = {
      { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "DiffView open" },
      { "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "DiffView close" },
    },
    config = true,
  },
}
