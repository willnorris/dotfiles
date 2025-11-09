return {
  -- disable LazyVim colorschemes
  { "folke/tokyonight.nvim", enabled = false },
  { "catppuccin/nvim", name = "catppuccin", enabled = false },

  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "wjn" },
  },
  {
    "nvim-mini/mini.base16",
  },
  { -- onedark colorscheme
    "navarasu/onedark.nvim",
    priority = 1000,
    opts = function(_, opts)
      opts = vim.tbl_deep_extend("force", opts, {
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

          GitSignsChange = { fg = "$yellow" },
          GitSignsChangeLn = { fg = "$yellow" },
          GitSignsChangeNr = { fg = "$yellow" },

          FzfLuaBorder = { fg = "$bg2" },
          FzfLuaHeaderText = { fg = "$blue" },
          FzfLuaHeaderBind = { fg = "$red" },
          FzfLuaBufFlagCur = { fg = "$red" },
          FzfLuaBufFlagAlt = { fg = "$cyan" },
          FzfLuaPathLineNr = { fg = "$green" },

          SignatureMarkText = { fg = "$red" },
          SignatureMarkerText = { fg = "$green" },

          SnacksDim = { fg = "$bg2" },
          SnacksIndent = { fg = "$bg0" },
          SnacksIndentScope = { fg = "$grey" },

          SnacksInputNormal = { bg = "$bg0" },
          SnacksInputBorder = { bg = "$bg0", fg = "$grey" },
          SnacksInputTitle = { bg = "$bg0", fg = "$fg" },

          BlinkCmpMenuBorder = { fg = "$grey", bg = "$bg0" },
          BlinkCmpDocBorder = { fg = "$grey", bg = "$bg0" },
          BlinkCmpMenu = { bg = "$bg0" },
          BlinkCmpMenuSelection = { bg = "$bg2" },

          WhichKeySeparator = { fg = "$grey" },
        },
      })
      -- if require("util").colorscheme() == "light" then
      --   opts.style = "light"
      -- end
      return opts
    end,
  },
}
