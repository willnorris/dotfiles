-- Automatically install packer if not present
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
  vim.cmd [[packadd packer.nvim]]
  require("user.plugins")
  require("packer").sync()
  print [[
 ======================================================
  New installation. Restart nvim when packer finishes.
 ======================================================]]
end

-- recompile packer on when plugins.lua is saved
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "plugins.lua",
  callback = function()
    vim.cmd [[source <afile>]]
    require("packer").compile()
  end
})
