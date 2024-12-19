-- Language support: LSP, formatters, linters
return {
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.lang.go" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.tailwind" },
  { import = "lazyvim.plugins.extras.lang.terraform" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  { import = "lazyvim.plugins.extras.util.dot" },

  { import = "lazyvim.plugins.extras.lang.markdown" },
  { "MeanderingProgrammer/render-markdown.nvim", enabled = false },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      local markdownlint = require("lint").linters["markdownlint-cli2"]
      markdownlint.args = {
        "--config", vim.fn.expand("~/.config/md.markdownlint.yaml"),
      }
      return opts
    end
  },

  -- Caddyfile syntax support
  { "isobit/vim-caddyfile" },

  { -- lspconfig
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = false,
              analyses = {
                fieldalignment = false,
              },
            },
          },
        },
        sourcekit = {
          cmd = { "xcrun", "sourcekit-lsp" },
          filetypes = { "swift" },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    opts = {
      cmd = { vim.fn.stdpath("data") .. "/mason/bin/jdtls" },
      root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
    },
    config = function(_, opts)
      require("jdtls").start_or_attach(opts)
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "",
          package_pending = "",
          package_uninstalled = "",
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft.lua = nil
      opts.formatters_by_ft.go = { "goimports" }
      return opts
    end,
  },

  { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.linting.eslint" },

  { -- Display LSP results in preview window
    "rmagatti/goto-preview",
    event = "VeryLazy",
    opts = {
      border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
      default_mappings = true,
      resizing_mappings = true,
      post_open_hook = function(_, winid)
        vim.keymap.set("n", "q", function()
          vim.api.nvim_win_close(winid, false)
        end)
      end,
    },
  },
}
