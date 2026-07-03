vim.opt_local.ts = 8
vim.opt_local.sw = 8
vim.opt_local.et = false
vim.opt_local.list = false
vim.opt_local.spell = true

-- Go has no max line-length, but set colorcolumn as a reference
vim.opt_local.colorcolumn = "81"

-- Add custom semantic tokens for:
--   "return" keyword
vim.api.nvim_create_autocmd("LspTokenUpdate", {
  callback = function(args)
    local token = args.data.token
    if token.type == "keyword" then
      local text = vim.api.nvim_buf_get_text(args.buf, token.line, token.start_col, token.line, token.end_col, {})[1]
      if text == "return" then
        vim.lsp.semantic_tokens.highlight_token(
          token, args.buf, args.data.client_id,
          "@lsp.typemod.keyword.return.go"
        )
      end
    end
  end,
})
