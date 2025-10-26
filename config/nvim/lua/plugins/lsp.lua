return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false
      },
      servers = {
        ["*"] = {
          keys = {
            -- disable <C-k>, since that interferes with cmp navigation
            { "<C-k>", false, mode = "i" },
          },
        },
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
