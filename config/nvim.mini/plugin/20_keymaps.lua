-- Keymaps

local nmap = function(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { desc = desc })
end

C.later(function()
  local bufremove = require("mini.bufremove")
  bufremove.setup()

  nmap("<Leader>bd", bufremove.delete, "Delete")
  nmap("<Leader>bD", function() bufremove.delete(0, true) end, "Delete!")
  nmap("H", "<cmd>bprev<cr>", "Go to previous buffer")
  nmap("L", "<cmd>bnext<cr>", "Go to next buffer")
end)

-- Configure default keyamps for code and LSP actions.
-- Many of these will be overwritten later by plugins.
vim.keymap.set({"n","x"}, "<leader>ca", vim.lsp.buf.code_action, {desc = "Code Action"})
vim.keymap.set({"n","x"}, "<leader>cf", vim.lsp.buf.format, {desc = "Format"})
nmap("<Leader>cd", vim.diagnostic.open_float, "Line diagnostics")
nmap("<Leader>cl", vim.lsp.codelens.run, "Lens")
nmap("<Leader>cr", vim.lsp.buf.rename, "Rename")

nmap("gd", vim.lsp.buf.definition, "Source definition")
nmap("gd", vim.lsp.buf.declaration, "Source definition")
nmap("gr", vim.lsp.buf.references, "References")
nmap("gI", vim.lsp.buf.implementation, "Implementation")
nmap("gy", vim.lsp.buf.type_definition, "Type definition")
nmap("gai", vim.lsp.buf.incoming_calls, "C[a]lls Incoming")
nmap("gao", vim.lsp.buf.outgoing_calls, "C[a]lls Outgoing")

nmap("<Leader>cd", function() vim.diagnostic.open_float() end, "Line diagnostics")

-- additional keymap groups to register with which-key
C.keymap_groups = {}
