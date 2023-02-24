local M = {}

local function lsp_activate_capabilities(client, bufnr)
  local autocmd = vim.api.nvim_create_autocmd

  require("illuminate").on_attach(client)

  if client.server_capabilities.codeLensProvider then
    autocmd({ "BufEnter", "CursorHold", "InsertLeave" },
      { buffer = bufnr, callback = vim.lsp.codelens.refresh })
  end
end

local function lsp_keymaps(bufnr)
  local wk_ok, wk = pcall(require, "which-key")
  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

  local keymap = vim.keymap.set
  local opts = function(o)
    return vim.tbl_extend("keep", o, { noremap = true, silent = true, buffer = bufnr })
  end

  if wk_ok then wk.register({ g = { name = "+goto" } }) end
  keymap("n", "gD", vim.lsp.buf.declaration, opts { desc = "code declaration" })
  keymap("n", "gd", vim.lsp.buf.definition, opts { desc = "code definition" })
  keymap("n", "gr", vim.lsp.buf.references, opts { desc = "code references" })
  keymap("n", "gc", vim.lsp.buf.incoming_calls, opts { desc = "code incoming_calls" })
  keymap("n", "gi", vim.lsp.buf.implementation, opts { desc = "code implementation" })
  keymap("n", "gl", vim.lsp.codelens.run, opts { desc = "run codelens" })
  keymap("n", "K", vim.lsp.buf.hover, opts { desc = "code hover" })
  keymap("n", "gk", vim.lsp.buf.signature_help, opts { desc = "code signature_help" })
  keymap("n", "<leader>rn", vim.lsp.buf.rename, opts { desc = "code rename" })
  keymap("n", "ga", vim.lsp.buf.code_action, opts { desc = "code action" })
  keymap("n", "gp", function() require("goto-preview").goto_preview_definition() end, opts { desc = "preview definition" })
  keymap("n", "gP", function() require("goto-preview").close_all_win() end, opts { desc = "close preview windows" })

  -- diagnostics
  keymap("n", "<leader>e", vim.diagnostic.open_float, opts { desc = "show diagnostic" })
  keymap("n", "[x", vim.diagnostic.goto_prev, opts { desc = "prev diagnostic" })
  keymap("n", "]x", vim.diagnostic.goto_next, opts { desc = "next diagnostic" })
  keymap("n", "<leader>q", vim.diagnostic.setloclist, opts { desc = "diagnostic loclist" })

  -- workspace folders
  if wk_ok then wk.register({ ["<leader>w"] = { name = "+workspace" } }) end
  keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts { desc = "add workspace folder" })
  keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts { desc = "remove workspace folder" })
  keymap('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts { desc = "list workspace folders" })

  keymap('n', '<leader>fm', function()
    vim.lsp.buf.format { async = true }
  end, opts { desc = "code format" })
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end
  lsp_activate_capabilities(client)
  lsp_keymaps(bufnr)
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
  M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
end

return M
