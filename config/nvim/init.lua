local ok, impatient = pcall(require, 'impatient')
if ok then
  impatient.enable_profile()
else
  vim.notify(impatient)
end

-- Automatically install packer if not present
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print "Installing packer"
  vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })

  vim.cmd [[packadd packer.nvim]]
  require("user.plugins")
  require("packer").sync()
end

-- Do all init in user/init.lua so impatient can cache it
require("user")
