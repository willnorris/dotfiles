local ok, _ = pcall(require, "lspconfig")
if not ok then
  return
end

require("user.lsp.lsp-installer")
require("user.lsp.handlers").setup()

-- Fix LspInfo window border (https://neovim.discourse.group/t/1566)
local win = require('lspconfig.ui.windows')
local _default_opts = win.default_opts
win.default_opts = function(options)
  local opts = _default_opts(options)
  opts.border = 'rounded'
  return opts
end
