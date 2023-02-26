local keymap = vim.keymap.set
local noremap = { noremap = true }

vim.cmd([[
  function! Preserve(command) "{{{
    " preparation: save last search, and cursor position.
    let _s=@/
    let view = winsaveview()
    " do the business:
    execute a:command
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call winrestview(view)
  endfunction "}}}
]])

-- movement
keymap("i", "jk", "<esc>", noremap)

-- buffer navigation
keymap("n", "<leader>;", "<C-^>", noremap)
keymap("n", "<leader>bd", "<Cmd>Bdelete<CR>")

keymap(
  "n",
  "<leader>!",
  "<Cmd>redraw!<CR><Cmd>redrawstatus!<CR><Cmd>nohlsearch<Bar>diffupdate<CR>",
  { desc = "redraw screen" }
)

-- Join lines and restore cursor location (J)
keymap("n", "J", [[<Cmd>call Preserve("join")<CR>]])

-- strip trailing whitespace
keymap("n", "_$", [[<Cmd>call Preserve("%s/\\s\\+$//e")<CR>]], { desc = "strip trailing whitespace" })

-- timestamp insertion
keymap("i", "<A-i>t", "<C-R>=system('timestamp -rfc3339')<CR>", { desc = "timestamp -rfc3339" })
keymap("i", "<A-i>z", "<C-R>=system('timestamp -rfc3339 -utc')<CR>", { desc = "timestamp -rfc3339 -utc" })
keymap("i", "<A-i>e", "<C-R>=system('timestamp -epoch')<CR>", { desc = "timestamp -epoch" })

-- Find and open the alternate file for the current path.
-- Requires alt command (https://github.com/uptech/alt)
vim.keymap.set("n", "<leader>.", function()
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
end)