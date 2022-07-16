vim.opt.ts = 8
vim.opt.sw = 8
vim.opt.et = false
vim.opt.list = false

-- Go has no max line-length, but set colorcolumn as a reference
vim.opt.colorcolumn = "81"


-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go" },
  callback = function()
    vim.lsp.buf.formatting_sync(nil, 3000)
  end,
})

-- organize imports on save (from https://github.com/neovim/nvim-lspconfig/issues/115#issuecomment-1130373799)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go" },
  callback = function()
    local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
    params.context = {only = {"source.organizeImports"}}

    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end,
})
