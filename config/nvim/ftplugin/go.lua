vim.opt_local.ts = 8
vim.opt_local.sw = 8
vim.opt_local.et = false
vim.opt_local.list = false
vim.opt_local.spell = true

-- Go has no max line-length, but set colorcolumn as a reference
vim.opt_local.colorcolumn = "81"

local augroup = vim.api.nvim_create_augroup("goformat", { clear = true })

-- format and organize imports on save
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup,
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
  end
})
