require "user.options"
require "user.plugins"
require "user.keymaps"
require "user.color"
require "user.cmp"
require "user.lsp"
require "user.telescope"

-- load user.work config if present
pcall("require", "user.work")
