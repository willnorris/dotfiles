require("config.lazy")
require("config.options")
require("config.keymaps")

-- load config.work config if present
pcall(require, "config.work")
