local lspconfig = require("lspconfig")
local lsp_installer = require("nvim-lsp-installer")

lsp_installer.setup({
  ui = {
    border = "rounded",
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  },
})

-- set default config for lsp servers
lspconfig.util.default_config = vim.tbl_deep_extend("force",
  lspconfig.util.default_config,
  {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }
)

-- configure installed lsp servers, loading settings from user/lsp/settings/<server>.lua if it exists.
for _, server in ipairs(lsp_installer.get_installed_servers()) do
  local opts = {}
  local ok, server_opts = pcall(require, "user.lsp.settings." .. server.name)
  if ok then
    opts = server_opts
  end
  lspconfig[server.name].setup(opts)
end

-- setup handlers
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
  -- Enable virtual text only on Warning or above
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
})

-- use telescope LSP handlers
local ok, tb = pcall(require, "telescope.builtin")
if ok then
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

-- Fix LspInfo window border (https://neovim.discourse.group/t/1566)
local win = require('lspconfig.ui.windows')
local _default_opts = win.default_opts
win.default_opts = function(options)
  local opts = _default_opts(options)
  opts.border = 'rounded'
  return opts
end
