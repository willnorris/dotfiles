local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- set leader before loading lazy.nvim
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("lazy").setup({
  spec = {
    { import = "user.plugins" },
  },
})
