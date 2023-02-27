return {
  {
    "zbirenbaum/copilot.lua",
    dependencies = {
      { "zbirenbaum/copilot-cmp", lazy = true, config = true },
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
        return vim.tbl_deep_extend("keep", {
          completion = {
            completeopt = "menu,menuone,noinsert,noselect",
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-k>"] = cmp.mapping.select_prev_item(),
            ["<C-j>"] = cmp.mapping.select_next_item(),
            ["<A-k>"] = cmp.mapping.scroll_docs( -2),
            ["<A-j>"] = cmp.mapping.scroll_docs(2),
            ["<C-c>"] = cmp.mapping.abort(),
            ["<C-y>"] = cmp.mapping.confirm({ select = true }),
            ["<C-o>"] = cmp.mapping.complete(),
            ["<CR>"] = cmp.mapping.confirm({ select = false }),
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
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
          confirm_opts = {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          },
          experimental = {
            native_menu = false,
          },
        }, opts)
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
}
