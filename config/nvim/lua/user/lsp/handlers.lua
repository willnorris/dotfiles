local M = {}

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "e" },
    { name = "DiagnosticSignWarn", text = "w" },
    { name = "DiagnosticSignInfo", text = "i" },
    { name = "DiagnosticSignHint", text = "h" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- enable virtual text
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })

  -- use telescope LSP handlers
  local tb = require("telescope.builtin")
  vim.lsp.handlers["callHierarchy/incomingCalls"] = tb.lsp_incoming_calls
  vim.lsp.handlers["callHierarchy/outgoingCalls"] = tb.lsp_outgoing_calls
  vim.lsp.handlers["textDocument/references"] = tb.lsp_references
  vim.lsp.handlers["textDocument/definition"] = tb.lsp_definitions
  vim.lsp.handlers["textDocument/typeDefinition"] = tb.lsp_type_definitions
  vim.lsp.handlers["textDocument/implementation"] = tb.lsp_implementations
  vim.lsp.handlers["textDocument/documentSymbol"] = tb.lsp_document_symbols
  vim.lsp.handlers["workspace/symbol"] = tb.lsp_workspace_symbols
  vim.lsp.handlers["textDocument/codeAction"] = tb.lsp_references
end

local function lsp_activate_capabilities(client)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]] ,
      false
    )
  end

  if client.resolved_capabilities.code_lens then
    vim.api.nvim_create_autocmd({"BufEnter", "CursorHold", "InsertLeave"}, {
      callback = vim.lsp.codelens.refresh,
    })
  end
end

local function lsp_keymaps(bufnr)
  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

  local keymap = vim.keymap.set
  local opts = function(o)
    return vim.tbl_extend("keep", o, { noremap = true, silent = true, buffer = bufnr })
  end
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

  -- diagnostics
  keymap("n", "<leader>e", vim.diagnostic.open_float, opts { desc = "show diagnostic" })
  keymap("n", "[d", vim.diagnostic.goto_prev, opts { desc = "prev diagnostic" })
  keymap("n", "]d", vim.diagnostic.goto_next, opts { desc = "next diagnostic" })
  keymap("n", "<leader>q", vim.diagnostic.setloclist, opts { desc = "diagnostic loclist" })

  -- workspace folders
  keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts { desc = "add workspace folder" })
  keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts { desc = "remove workspace folder" })
  keymap('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts { desc = "list workspace folders" })

  keymap('n', '<leader>fm', vim.lsp.buf.formatting, opts { desc = "code format" })
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
  end
  lsp_keymaps(bufnr)
  lsp_activate_capabilities(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not ok then
  return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
