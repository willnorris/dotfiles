return {
  -- disable LazyVim colorschemes
  { "folke/tokyonight.nvim", enabled = false },
  { "catppuccin/nvim", name = "catppuccin", enabled = false },

  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "onedark" },
  },
  { -- onedark colorscheme
    "navarasu/onedark.nvim",
    priority = 1000,
    opts = {
      transparent = true,
      ending_tildes = true,

      code_style = {
        comments = "none",
      },

      -- color palette: https://github.com/navarasu/onedark.nvim/blob/master/lua/onedark/palette.lua
      highlights = {
        Folded = { bg = "$bg0" },
        NormalFloat = { bg = "$bg0" },
        FloatTitle = { bg = "$bg0" },
        FloatBorder = { bg = "$bg0" },
        NotifyBackground = { bg = "$bg0" },

        -- onedark.nvim already uses a colored undercurl for spelling highlights,
        -- but my terminal isn't currently rendering them properly.
        -- for now, just highlight the text.
        SpellBad = { fg = "$red" },
        SpellCap = { fg = "$yellow" },
        SpellRare = { fg = "$purple" },
        SpellLocal = { fg = "$blue" },

        Twilight = { bg = "$none", fg = "$bg2" },
        ZenBg = { fg = "$fg" },

        GitSignsChange = { fg = "$yellow" },
        GitSignsChangeLn = { fg = "$yellow" },
        GitSignsChangeNr = { fg = "$yellow" },

        FzfLuaBorder = { fg = "$bg2" },

        SignatureMarkText = { fg = "$red" },
        SignatureMarkerText = { fg = "$green" },

        SnacksIndent = { fg = "$bg0" },
        SnacksIndentScope = { fg = "$grey" },

        BlinkCmpMenuBorder = { fg = "$grey", bg = "$bg0" },
        BlinkCmpDocBorder = { fg = "$grey", bg = "$bg0" },
        BlinkCmpMenu = { bg = "$bg0" },
        BlinkCmpMenuSelection = { bg = "$bg2" },

        WhichKeySeparator = { fg = "$grey" },
      },
    },
  },
}
