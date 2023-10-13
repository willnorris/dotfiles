-- clear marks a-z on buffer enter
-- See: https://github.com/chentoast/marks.nvim/issues/13
--      https://github.com/neovim/neovim/issues/4295
local delm_augroup = vim.api.nvim_create_augroup("clear_marks", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = delm_augroup,
  command = "delm a-z",
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    if vim.bo.buftype == "nofile" then
      vim.b.miniindentscope_disable = true
      vim.wo.list = false
      vim.bo.expandtab = false
    end
  end,
})

-- Disable focus.nvim on certain buftypes and filetypes
local focus_augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

vim.api.nvim_create_autocmd("WinEnter", {
  group = focus_augroup,
  callback = function(_)
    local ignore_buftypes = { "nofile", "prompt", "popup", "tailscale" }
    if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
      vim.b.focus_disable = true
    end
  end,
  desc = "Disable focus autoresize for BufType",
})

vim.api.nvim_create_autocmd("FileType", {
  group = focus_augroup,
  callback = function(_)
    local ignore_filetypes = { "fugitive", "gitcommit", "outline", "neo-tree" }
    if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
      vim.b.focus_disable = true
    end
  end,
  desc = "Disable focus autoresize for FileType",
})
