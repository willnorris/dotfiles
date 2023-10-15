local keymap = vim.keymap.set
local Util = require("lazyvim.util")

-- https://stackoverflow.com/questions/70691265
local preserve = function(arguments)
  local command = string.format("keepjumps keeppatterns execute %q", arguments)
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_command(command)
  local lastline = vim.fn.line("$")
  if lastline and line > lastline then
    line = lastline
  end
  vim.api.nvim_win_set_cursor(0, { line, col })
end

-- buffer navigation
keymap("n", "<leader>;", "<C-^>", { noremap = true })

keymap("n", "<C-C>", function()
  require("notify").dismiss({ silent = true, pending = true })
  vim.cmd("mode|redrawstatus!|redrawtabline")
  vim.cmd("nohlsearch|diffupdate")
end, { desc = "clear and redraw screen" })

keymap("n", "<leader>uo", function() Util.toggle("foldcolumn", true, { "1", "0" }) end, { desc = "Toggle fold column" })
keymap("n", "<leader>ug",
  function() Util.toggle("signcolumn", true, { "no", "auto" }) end, { desc = "Toggle sign column" })
keymap("n", "<leader>ul", function() Util.toggle("number", true) end, { desc = "Toggle line numbers" })

-- https://github.com/wookayin/dotfiles/commit/96d9355
keymap("n", "<leader>wc", function()
  local closed_windows = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then        -- is_floating_window?
      vim.api.nvim_win_close(win, false) -- do not force
      table.insert(closed_windows, win)
    end
  end
end, { desc = "Close all floating windows" })

-- Join lines and restore cursor location (J)
keymap("n", "J", function() preserve("join") end, { desc = "Join lines" })

-- strip trailing whitespace
keymap("n", "_$", function() preserve("%s/\\s\\+$//e") end, { desc = "strip trailing whitespace" })

-- timestamp insertion
keymap("i", "<A-i>t", "<C-R>=system('timestamp -rfc3339')<CR>", { desc = "timestamp -rfc3339" })
keymap("i", "<A-i>z", "<C-R>=system('timestamp -rfc3339 -utc')<CR>", { desc = "timestamp -rfc3339 -utc" })
keymap("i", "<A-i>e", "<C-R>=system('timestamp -epoch')<CR>", { desc = "timestamp -epoch" })

-- j/k to move in wildmenu
keymap("c", "<c-j>", "<c-n>", { remap = true })
keymap("c", "<c-k>", "<c-p>", { remap = true })

-- Find and open the alternate file for the current path.
-- Requires alt command (https://github.com/uptech/alt)
local open_alt_file = function()
  if vim.fn.executable("alt") ~= 1 then
    vim.notify("Need to install https://github.com/uptech/alt")
    return
  end

  local alt = vim.fn.system("alt " .. vim.fn.expand("%"))
  if vim.v.shell_error ~= 0 then
    vim.notify(alt)
    return
  end
  if alt ~= "" then
    vim.fn.execute(":e " .. alt)
  else
    vim.notify("Alt file not found for " .. vim.fn.expand("%"))
  end
end
keymap("n", "<leader>.", open_alt_file, { desc = "Open alternate file" })

-- Restore 'gw' to default behavior by resetting formatexpr if null-ls
-- is not providing any formatting generators.
-- See: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131
require("lazyvim.util").lsp.on_attach(function(client, buf)
  if client.name == "null-ls" then
    if not require("null-ls.generators").can_run(vim.bo[buf].filetype, require("null-ls.methods").lsp.FORMATTING) then
      vim.bo[buf].formatexpr = nil
    end
  end
end)

-- replace selection with text from default register without changing the register
keymap("x", "<_dP>p", [["_dP]], { desc = "Paste and keep default register" })
