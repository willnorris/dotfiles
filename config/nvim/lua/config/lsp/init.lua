local lspconfig = require("lspconfig")

local mason_ok, mason = pcall(require, "mason")
if mason_ok then
  mason.setup({
    ui = {
      border = "rounded",
      icons = {
        package_installed = "",
        package_pending = "",
        package_uninstalled = ""
      }
    },
  })
end

-- set default config for lsp servers
lspconfig.util.default_config = vim.tbl_deep_extend("force",
  lspconfig.util.default_config,
  {
    on_attach = require("config.lsp.handlers").on_attach,
    capabilities = require("config.lsp.handlers").capabilities,
  }
)

-- configure installed lsp servers, loading settings from user/lsp/settings/<server>.lua if it exists.
local mlsp_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if mlsp_ok then
  mason_lspconfig.setup()
  mason_lspconfig.setup_handlers {
    function(server_name)
      local opts = {}
      local ok, server_opts = pcall(require, "config.lsp.settings." .. server_name)
      if ok then
        opts = server_opts
      end
      lspconfig[server_name].setup(opts)
    end,
  }
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
local tb_ok, tb = pcall(require, "telescope.builtin")
if tb_ok then
  vim.lsp.handlers["callHierarchy/incomingCalls"] = tb.lsp_incoming_calls
  vim.lsp.handlers["callHierarchy/outgoingCalls"] = tb.lsp_outgoing_calls
  vim.lsp.handlers["textDocument/references"] = tb.lsp_references
  vim.lsp.handlers["textDocument/typeDefinition"] = tb.lsp_type_definitions
  vim.lsp.handlers["textDocument/implementation"] = tb.lsp_implementations
  vim.lsp.handlers["textDocument/documentSymbol"] = tb.lsp_document_symbols
  vim.lsp.handlers["workspace/symbol"] = tb.lsp_workspace_symbols

  -- causes issues with goto-preview
  --vim.lsp.handlers["textDocument/definition"] = tb.lsp_definitions
end

-- register additional null-ls handlers
local nl_ok, null_ls = pcall(require, "null-ls")
if nl_ok then
  null_ls.setup {
    sources = {
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.code_actions.shellcheck,
      null_ls.builtins.diagnostics.shellcheck,
    }
  }
end

-- unobtrusive progress indicator
local fidget_ok, fidget = pcall(require, "fidget")
if fidget_ok then
  fidget.setup {
    window = {
      blend = 0,
    },
  }
end

-- keymap to toggle LSP virtual text
local tl_ok, tl = pcall(require, 'toggle_lsp_diagnostics')
if tl_ok then
  tl.init({
    update_in_insert = false,
  })
  vim.keymap.set("n", "yoxx", "<Plug>(toggle-lsp-diag-vtext)", { desc = "Toggle LSP virtual text" })
end

-- Fix LspInfo window border (https://neovim.discourse.group/t/1566)
local win = require('lspconfig.ui.windows')
local _default_opts = win.default_opts
win.default_opts = function(options)
  local opts = _default_opts(options)
  opts.border = 'rounded'
  return opts
end
