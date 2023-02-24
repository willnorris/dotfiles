require("lualine").setup {
  options = {
    theme = "onedark",
    icons_enabled = false,
    section_separators = "",
    component_separators = "",
  },
  sections = {
    lualine_a = {
      { "mode", fmt = function(str) return str:sub(1, 1) end }
    },
    lualine_c = {
      { "filename", color = { fg = "white" } },
      function()
        return require('nvim-treesitter').statusline({
          separator = "  ",
        })
      end,
    },
  },
  tabline = {
    lualine_a = { { "buffers", mode = 2 } },
    lualine_z = { { "tabs", mode = 2 } },
  }
}
