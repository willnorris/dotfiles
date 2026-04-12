C.later(function()
  vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
  vim.lsp.enable({
    "lua_ls",
  })
end)

C.later(function()
  vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })
  local conform = require('conform')
  conform.setup({
    default_format_opts = {
      -- Allow formatting from LSP server if no dedicated formatter is available
      lsp_format = 'fallback',
    },
    -- Map of filetype to formatters
    -- Make sure that necessary CLI tool is available
    -- formatters_by_ft = { lua = { 'stylua' } },
  })
  vim.keymap.set({ 'n', 'x' }, '<Leader>cf',
    function() conform.format() end,
    { desc = 'Format' })
  vim.keymap.set({ 'n', 'x' }, "<leader>cF",
    function() conform.format({ formatters = { "injected" }, timeout_ms = 3000 }) end,
    { desc = "Format Injected Langs" }
  )
end)
