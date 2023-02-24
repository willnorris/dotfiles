require "user.lazy"
require "user.options"
require "user.keymaps"

-- load user.work config if present
pcall(require, "user.work")
