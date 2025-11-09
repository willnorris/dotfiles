require("mini.git").setup()
require("mini.diff").setup({
  view = {
    style = "sign",
    signs = { add = "+", change = "~", delete = '_' }
  }
})
