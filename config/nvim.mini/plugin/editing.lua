C.later(function()
  vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
  vim.lsp.enable({
    "lua_ls",
  })
end)
