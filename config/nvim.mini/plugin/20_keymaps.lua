-- Keymaps
local keymap = vim.keymap.set

keymap("n", "<leader>bd", function() require("mini.bufremove").delete() end, { desc = "Close buffer" })
keymap("n", "H", "<cmd>bprev<cr>", { desc = "Go to previous buffer" })
keymap("n", "L", "<cmd>bnext<cr>", { desc = "Go to next buffer" })
