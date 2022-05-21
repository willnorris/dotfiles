local options = {
  -- general
  wildmode = "list:longest,full",
  undofile = true,
  spellfile = vim.fn.stdpath("config") .. "/en.utf-8.add",
}


for k, v in pairs (options) do
  vim.opt[k] = v
end
