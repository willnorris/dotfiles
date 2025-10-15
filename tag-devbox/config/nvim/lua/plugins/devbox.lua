-- Language support: LSP, formatters, linters
return {
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.lang.go" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  { import = "lazyvim.plugins.extras.lang.tailwind" },
  { import = "lazyvim.plugins.extras.lang.terraform" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.zig" },

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
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft.lua = nil
      opts.formatters_by_ft.go = { "goimports" }
      opts.formatters_by_ft.mdx = { "prettier", "markdownlint-cli2", "markdown-toc" }
      return opts
    end,
  },

  { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.linting.eslint" },
}
