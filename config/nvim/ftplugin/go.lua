vim.opt.ts = 8
vim.opt.sw = 8
vim.opt.et = false
vim.opt.list = false

-- Go has no max line-length, but set colorcolumn as a reference
vim.opt.colorcolumn = "81"

vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
