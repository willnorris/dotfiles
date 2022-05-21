require "user.options"
require "user.plugins"
require "user.keymaps"
require "user.color"

-- load user.work config if present
pcall("require", "user.work")
