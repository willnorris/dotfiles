vim.opt.ts = 8
vim.opt.sw = 8
vim.opt.et = false
vim.opt.list = false

-- Go has no max line-length, but set colorcolumn as a reference
vim.opt.colorcolumn = "81"

-- organize imports (from https://github.com/neovim/nvim-lspconfig/issues/115#issuecomment-1130373799)
local function go_import()
  local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
  params.context = { only = { "source.organizeImports" } }

  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.kind == "source.organizeImports" then
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
        elseif r.command then
          vim.lsp.buf.execute_command({command = r.command})
        end
      end
    end
  end
end

local augroup = vim.api.nvim_create_augroup("goformat", { clear = true })

-- format and organize imports on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = { "*.go" },
  callback = function ()
    go_import()
    vim.lsp.buf.format { async = true }
  end,
})
