local util = require "lspconfig/util"

local opt = {
  cmd = {"gopls", "serve"},
  filetypes = {"go", "gomod"},
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      -- env = {
      --   GOFLAGS = "-tags=windows,linux,darwin",
      -- },
      staticcheck = true,
    },
  },
}

return opt
