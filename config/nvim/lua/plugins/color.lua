return {
  -- disable LazyVim colorschemes
  { "folke/tokyonight.nvim", enabled = false },
  { "catppuccin/nvim", name = "catppuccin", enabled = false },

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

        DashboardHeader = { fg = "$blue" },
        Twilight = { bg = "$none", fg = "$bg2" },
        ZenBg = { fg = "$fg" },

        GitSignsChange = { fg = "$yellow" },
        GitSignsChangeLn = { fg = "$yellow" },
        GitSignsChangeNr = { fg = "$yellow" },

        SignatureMarkText = { fg = "$red" },
        SignatureMarkerText = { fg = "$green" },

        TelescopeBorder = { fg = "$grey" },
        TelescopePromptBorder = { fg = "$grey" },
        TelescopeResultsBorder = { fg = "$grey" },
        TelescopePreviewBorder = { fg = "$grey" },
        TelescopeTitle = { fg = "$fg" },

        MiniStarterHeader = { fg = "$blue" },
        MiniStarterFooter = { fg = "$grey" },
        MiniStarterItemPrefix = { fg = "$red" },

        WhichKeySeparator = { fg = "$grey" },
      },
    },
  },
}
