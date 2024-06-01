return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable <c-k>, since that interferes with cmp navigation
      keys[#keys + 1] = { "<c-k>", false, mode = "i" }

      -- disable gy and use gt instead for type definitions
      keys[#keys + 1] = { "gy", false }
      keys[#keys + 1] = {
        "gt",
        function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end,
        desc = "Goto Type Definition"
      }
    end,
    opts = {
      inlay_hints = {
        enabled = false
      },
    },
  },
}
