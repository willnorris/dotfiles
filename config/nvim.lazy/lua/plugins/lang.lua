-- Language support: LSP, formatters, linters
return {
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  { import = "lazyvim.plugins.extras.util.dot" },

  { import = "lazyvim.plugins.extras.lang.markdown" },
  { "MeanderingProgrammer/render-markdown.nvim",    enabled = false },
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
  { "davidmh/mdx.nvim", config = true },

  {
    "mason-org/mason.nvim",
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

  { -- Display LSP results in preview window
    "rmagatti/goto-preview",
    event = "VeryLazy",
    keys = {
      -- use 'y' in addition to 't' for type definition to match LSP mappings
      { "gpy", function() require("goto-preview").goto_preview_type_definition() end, desc = "Preview type definition" },
    },
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
