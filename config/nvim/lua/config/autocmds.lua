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
    local ignore_filetypes = { "fugitive", "gitcommit", "outline", "neo-tree", "snacks_picker_list" }
    if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
      vim.b.focus_disable = true
    end
  end,
  desc = "Disable focus autoresize for FileType",
})
