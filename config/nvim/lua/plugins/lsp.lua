return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable <C-k>, since that interferes with cmp navigation
      keys[#keys + 1] = { "<C-k>", false, mode = "i" }
    end,
    opts = {
      inlay_hints = {
        enabled = false
      },
      servers = {
        jsonls = {
          settings = {
            json = {
              schemas = {
                { fileMatch = { "*.hujson", "*.jsonc" }, schema = { allowTrailingCommas = true } },
              },
            },
          },
        },
      },
    },
  },
}
