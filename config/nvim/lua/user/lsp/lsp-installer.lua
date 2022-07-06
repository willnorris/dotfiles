local installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not installer_ok then
  return
end

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
  return
end


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
