-- Keymaps

local nmap = function(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { desc = desc })
end

C.later(function() require("mini.bufremove").setup() end)

nmap("<Leader>bd", "<Cmd>lua MiniBufremove.delete()<CR>", "Delete")
nmap("<Leader>bD", "<Cmd>lua MiniBufremove.delete(0, true)<CR>", "Delete!")
nmap("H", "<cmd>bprev<cr>", "Go to previous buffer")
nmap("L", "<cmd>bnext<cr>", "Go to next buffer")

nmap("<Leader>cd", function() vim.diagnostic.open_float() end, "Line diagnostics")

-- additional keymap groups to register with which-key
C.keymap_groups = {}
