require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.color"
require "user.cmp"

-- load user.work config if present
pcall("require", "user.work")
