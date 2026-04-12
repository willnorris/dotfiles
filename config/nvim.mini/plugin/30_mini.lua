C.now(function()
  require("mini.basics").setup({
    options = {
      basic = false,
      win_border = "solid",
    },
    mappings = {
      basic = false,
      option_toggle_prefix = "<Leader>u",
      windows = true,
    },
    autocommands = {
        relnum_in_visual_mode = true,
    },
    silent = true,
  })
end)
