local keymap = vim.keymap.set
local noremap = { noremap = true }

vim.cmd [[
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
]]

-- set leader and local leader key
keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- movement
keymap("i", "jk", "<esc>", noremap)
keymap("", "j", "gj", noremap)
keymap("", "k", "gk", noremap)

-- move around split windows with ctrl
keymap("n", "<C-H>", "<C-W>h", noremap)
keymap("n", "<C-J>", "<C-W>j", noremap)
keymap("n", "<C-K>", "<C-W>k", noremap)
keymap("n", "<C-L>", "<C-W>l", noremap)

-- buffer navigation
keymap("n", "<leader>;", "<C-^>", noremap)
keymap("n", "<leader>]", ":bnext<CR>")
keymap("n", "<leader>[", ":bprev<CR>")
keymap("n", "<leader>ls", ":Buffers<CR>")
keymap("n", "<leader>dd", ":bd<CR>")

-- tab navigation
keymap("n", "<leader>tn", ":tabnew<CR>")
keymap("n", "<leader>tc", ":tabclose<CR>")
keymap("n", "<S-L>", ":tabnext<CR>")
keymap("n", "<S-H>", ":tabprevious<CR>")

keymap("n", "<leader>!", ":redraw!<CR>:redrawstatus!<CR>")
keymap("n", "<leader>R", ":source $MYVIMRC<CR>")

-- Join lines and restore cursor location (J)
keymap("n", "J", [[:call Preserve("join")<CR>]])

-- strip trailing whitespace
keymap("n", "_$", [[:call Preserve("%s/\\s\\+$//e")<CR>]])

-- timestamp insertion
keymap("i", "<C-L>t", "<C-R>=system('timestamp -rfc3339')<CR>")
keymap("i", "<C-L>z", "<C-R>=system('timestamp -rfc3339 -utc')<CR>")
keymap("i", "<C-L>e", "<C-R>=system('timestamp -epoch')<CR>")
