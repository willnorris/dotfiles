-- Keymaps

local nmap = function(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { desc = desc })
end
C.nmap = nmap

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Execute command and preserve cursor location.
local preserve = function(arguments)
  local curpos = vim.api.nvim_win_get_cursor(0)
  vim.cmd(string.format("keeppatterns keeppatterns execute %q", arguments))
  vim.api.nvim_win_set_cursor(0, curpos)
end

nmap("<C-C>", function()
  vim.cmd("mode|redrawstatus!|redrawtabline")
  vim.cmd("nohlsearch|diffupdate")
end, "clear and redraw screen")

-- https://github.com/wookayin/dotfiles/commit/96d9355
nmap("<Leader>wc", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then        -- is_floating_window?
      vim.api.nvim_win_close(win, false) -- do not force
    end
  end
end, "Close all floating windows")

-- close windows with temporary buffers with 'q'
C.autocmd("FileType",
  { "help", "qf", "lspinfo", "checkhealth", "man", "notify" },
  function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = event.buf,
      silent = true,
    })
  end, "close window with 'q'")

-- Join lines and restore cursor location (J)
nmap("J", function() preserve("join") end, "Join lines")

-- strip trailing whitespace
nmap("_$", function() require("mini.trailspace").trim() end, "strip trailing whitespace")

local mod = require("util").mod
-- timestamp insertion
vim.keymap.set("i", mod("i") .. "t", "<C-R>=system('timestamp -rfc3339')<CR>", { desc = "timestamp -rfc3339" })
vim.keymap.set("i", mod("i") .. "z", "<C-R>=system('timestamp -rfc3339 -utc')<CR>", { desc = "timestamp -rfc3339 -utc" })
vim.keymap.set("i", mod("i") .. "e", "<C-R>=system('timestamp -epoch')<CR>", { desc = "timestamp -epoch" })

-- replace selection with text from default register without changing the register
vim.keymap.set("x", "po", [["_dP]], { desc = "Paste and keep default register" })

-- yank text to system clipboard
vim.keymap.set({ "n", "v" }, "Y", [["+y]], { desc = "Yank to system clipboard" })
C.autocmd("TextYankPost", "*", function() vim.hl.on_yank() end, "Highlight on yank")

-- highlights under cursor
nmap("<leader>ui", vim.show_pos, "Inspect Pos")
nmap("<leader>uI", function()
  vim.treesitter.inspect_tree()
  vim.api.nvim_input("I")
end, "Inspect Tree")

-- buffer and tab navigation
C.later(function()
  local bufremove = require("mini.bufremove")
  bufremove.setup()

  nmap("<Leader>bd", bufremove.delete, "Delete")
  nmap("<Leader>bD", function() bufremove.delete(0, true) end, "Delete!")
  nmap("H", "<cmd>bprev<cr>", "Go to previous buffer")
  nmap("L", "<cmd>bnext<cr>", "Go to next buffer")
  vim.keymap.set("n", "<Leader>;", "<C-^>", { noremap = true, desc = "Last buffer" })

  -- tabs
  -- builtin keymaps: gt - next, gT - prev, g<Tab> - recent
  nmap("<Leader><Tab>c", "<Cmd>tabclose<CR>", "Close Tab")
  nmap("<Leader><Tab>n", "<Cmd>tabnew<CR>", "New Tab")
  table.insert(C.keymap_groups, { "<Leader><Tab>", group = "tabs" })
end)

-- remove default gr* keymaps
vim.keymap.del({ "n", "x" }, "gra")
for _, k in pairs({ "gri", "grn", "grr", "grt", "grx", "gO" }) do
  vim.keymap.del("n", k)
end

-- Configure default keyamps for code and LSP actions.
-- Many of these will be overwritten later by plugins.
vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set({ "n", "x" }, "<leader>cf", vim.lsp.buf.format, { desc = "Format" })
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

-- store additional keymap groups to register with which-key
C.keymap_groups = {}
