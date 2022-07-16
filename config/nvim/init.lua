require "user.options"
require "user.plugins"
require "user.keymaps"
require "user.color"
require "user.lsp"

-- load user.work config if present
pcall("require", "user.work")
