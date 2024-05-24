return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable <c-k>, since that interferes with cmp navigation
      keys[#keys + 1] = { "<c-k>", false, mode = "i" }
    end,
  }
}
