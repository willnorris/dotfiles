return {
  {
    "zbirenbaum/copilot.lua",
    dependencies = {
      { "zbirenbaum/copilot-cmp", config = true },
    },
    event = "VimEnter",
    opts = {
      filetypes = {
        ["dap-repl"] = false,
      },
    },
  },

  -- auto completion
  {
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        -- Completion plugins
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "zbirenbaum/copilot-cmp",
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
            ["<A-k>"] = cmp.mapping.scroll_docs( -2),
            ["<A-j>"] = cmp.mapping.scroll_docs(2),
            ["<C-c>"] = cmp.mapping.abort(),
            ["<C-y>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
            ["<C-o>"] = cmp.mapping.complete(),
            ["<CR>"] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace }),
          }),
          sources = cmp.config.sources({
            { name = "nvim_lsp_signature_help" },
            { name = "nvim_lsp" },
            { name = "copilot" },
            { name = "orgmode" },
            { name = "nvim_lua" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
            { name = "spell" },
          }),
          window = {
            completion = cmp.config.window.bordered({winhighlight="Search:None"}),
            documentation = cmp.config.window.bordered({winhighlight="Search:None"}),
          },
          confirm_opts = {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          },
          experimental = {
            native_menu = false,
          },
        })
      end,
    },
  },

  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "ys", -- Add surrounding in Normal and Visual modes
        delete = "ds", -- Delete surrounding
        replace = "cs", -- Replace surrounding
      },
    },
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "antoinemadec/FixCursorHold.nvim",
      { "nvim-neotest/neotest-go", },
      { "nvim-neotest/neotest-python", },
    },
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "run nearest test" },
      { "<leader>tf", function()
        require("neotest").run.run(vim.fn.expand("%"))
      end, { desc = "test file" } },
      { "<leader>tl", function() require("neotest").run.run_last() end, { desc = "run last test" } },
      { "<leader>ts", function() require("neotest").summary.toggle() end, { desc = "show test summary" } },
      { "<leader>to", function() require("neotest").output.open() end, { desc = "show test output" } },
      { "<leader>tw", function()
        require("neotest").output.open({
          open_win = function()
            vim.cmd("bel split")
          end,
        })
      end, { desc = "show test window" } },
    },
    opts = function ()
      return {
        adapters = {
          require("neotest-go"),
          require("neotest-python"),
        },
        icons = {
          expanded = "┐",
          final_child_prefix = "└",
          failed = "",
          passed = "",
          running = "",
        },
        output = {
          open_on_run = false,
        },
      }
    end,
    config = function(_, opts)
      local neotest = require("neotest")
      neotest.setup(opts)

      vim.diagnostic.config({
        signs = true,
        virtual_text = true,
      }, vim.api.nvim_create_namespace("neotest"))

      require("which-key").register({ ["<leader>t"] = { name = "+testing" } })
    end,
  },

  {
    {
      "mfussenegger/nvim-dap",
      keys = {
        { "<leader>dd", function() require("dapui").toggle() end,          desc = "debug: toggle UI" },
        { "<leader>dk", function() require("dap").continue() end,          desc = "debug: continue" },
        { "<leader>dj", function() require("dap").step_over() end,         desc = "debug: step over" },
        { "<leader>dl", function() require("dap").step_into() end,         desc = "debug: step into" },
        { "<leader>dh", function() require("dap").step_out() end,          desc = "debug: step out" },
        { "<leader>dl", function() require("dap").run_last() end,          desc = "debug: run last" },
        { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "debug: toggle breakpoint" },
        { "<leader>dt", function() require("dap").terminate() end,         desc = "debug: terminate session" },
      },
      dependencies = {
        { "rcarriga/nvim-dap-ui", config = true },
        { "leoluz/nvim-dap-go", config = true },
        {
          "theHamsta/nvim-dap-virtual-text",
          opts = {
            commented = true,
          },
        },
      }
    },
  },

}
