return {
  { import = "lazyvim.plugins.extras.coding.copilot" },

  { "echasnovski/mini.bracketed", config = true },
  { "echasnovski/mini.pairs", enabled = false },

  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Completion plugins
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "f3fora/cmp-spell",
      "onsails/lspkind.nvim",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      return vim.tbl_deep_extend("force", opts, {
        completion = {
          completeopt = "menu,menuone,noinsert,noselect",
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<A-k>"] = cmp.mapping.scroll_docs(-2),
          ["<A-j>"] = cmp.mapping.scroll_docs(2),
          ["<C-c>"] = cmp.mapping.abort(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
          ["<C-o>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace }),
        }),
        sources = cmp.config.sources(vim.list_extend(opts.sources, {
          { name = "nvim_lsp_signature_help" },
          { name = "orgmode" },
          { name = "nvim_lua" },
          { name = "spell" },
        })),
        window = {
          completion = cmp.config.window.bordered({ winhighlight = "Search:None" }),
          documentation = cmp.config.window.bordered({ winhighlight = "Search:None" }),
        },
      })
    end,
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
