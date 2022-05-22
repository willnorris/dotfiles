require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.color"

-- load user.work config if present
pcall("require", "user.work")
