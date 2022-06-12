require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.color"
require "user.cmp"
require "user.lsp"

-- load user.work config if present
pcall("require", "user.work")
