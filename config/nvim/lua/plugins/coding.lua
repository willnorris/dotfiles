return {
  { import = "lazyvim.plugins.extras.ai.copilot" },

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
      "gitaarik/nvim-cmp-toggle",
    },
    keys = {
      { "<leader>ua", ":NvimCmpToggle<CR>", desc = "Toggle autocomplete" },
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local mod = require("util").mod
      return vim.tbl_deep_extend("force", opts, {
        completion = {
          completeopt = "menu,menuone,noinsert,noselect",
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.select_prev_item({ count = 10 }),
          ["<C-f>"] = cmp.mapping.select_next_item({ count = 10 }),
          [mod("k")] = cmp.mapping.scroll_docs(-2),
          [mod("j")] = cmp.mapping.scroll_docs(2),
          ["<M-k>"] = cmp.mapping.scroll_docs(-2),
          ["<M-j>"] = cmp.mapping.scroll_docs(2),
          ["<C-c>"] = cmp.mapping.abort(),
          ["<C-y>"] = require("lazyvim.util").cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
          ["<C-o>"] = cmp.mapping.complete(),
          ["<CR>"] = function(fallback) fallback() end,
        }),
        sources = cmp.config.sources(vim.list_extend(opts.sources, {
          { name = "nvim_lsp_signature_help" },
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
