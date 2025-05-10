return {
  { "mason-org/mason.nvim", version = "1.11.0" },
  { "mason-org/mason-lspconfig.nvim", version = "1.32.0" },

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
    },
  },
}
