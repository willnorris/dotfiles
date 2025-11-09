-- wjn is my custom mini.base16 color scheme.
-- It's really just a onedark color palette with custom higlights.

local p
if vim.o.background == "light" then
  p = {
    base00 = "#dedede",
    base01 = "#c9c9c9",
    base02 = "#b6bdca",
    base03 = "#abb2bf",
    base04 = "#565c64",
    base05 = "#3e4451",
    base06 = "#353b45",
    base07 = "#282c34",
    base08 = "#e06c75",
    base09 = "#d19a66",
    base0A = "#e5c07b",
    base0B = "#40A14F",
    base0C = "#0997B3",
    base0D = "#0184BC",
    base0E = "#c678dd",
    base0F = "#be5046",
  }
else
  p = {
    base00 = "#1e1f24",
    base01 = "#282c34",
    base02 = "#3e4451",
    base03 = "#545862",
    base04 = "#848b98",
    base05 = "#abb2bf",
    base06 = "#b6bdca",
    base07 = "#c8ccd4",
    base08 = "#e06c75",
    base09 = "#d19a66",
    base0A = "#e5c07b",
    base0B = "#98c379",
    base0C = "#56b6c2",
    base0D = "#61afef",
    base0E = "#c678dd",
    base0F = "#be5046",
  }
end

require("mini.base16").setup({
  palette = p,
  plugins = {
    ["akinsho/bufferline.nvim"] = false,
  },
})
vim.g.colors_name = "wjn"

local c = {
  red     = p.base08,
  orange  = p.base09,
  yellow  = p.base0A,
  green   = p.base0B,
  cyan    = p.base0C,
  blue    = p.base0D,
  purple  = p.base0E,
  darkred = p.base0F,
}

local highlights = {
  -- Normal = { fg = "fg" },
  -- NormalNC = { fg = p.base05 },
  -- NormalFloat = { bg = p.base00 },
  FloatBorder = { fg = p.base03, bg = p.base01 },
  FloatTitle = { fg = p.base05, bg = p.base01 },
  WinSeparator = { fg = p.base02 },

  LineNr = { fg = p.base03 },
  SignColumn = { fg = p.base03 },
  CursorLineNr = { fg = p.base05 },
  CursorLineSign = {},
  Delimiter = { fg = p.base05 },

  GitSignsAdd = { link = "Added" },
  GitSignsChange = { link = "Changed" },
  GitSignsDelete = { link = "Removed" },

  SnacksIndent = { fg = p.base01 },
  SnacksIndentScope = { fg = p.base03 },

  SnacksInputNormal = {},
  SnacksInputBorder = { fg = p.base03 },
  SnacksInputTitle = { fg = p.base04 },
  SnacksPicker = { fg = p.base05 },
  SnacksPickerBorder = { fg = p.base03 },
  SnacksPickerIcon = { fg = c.red },
  SnacksPickerPrompt = { fg = c.red },

  MiniTablineFill = { bg = p.base01 },
  MiniTablineVisible = { bg = p.base01 },
  MiniTablineHidden = { bg = p.base01 },

  PmenuBorder = { fg = p.base03, bg = p.base01 },
  BlinkCmpMenuBorder = { link = "PmenuBorder" },
  BlinkCmpDocBorder = { link = "PmenuBorder" },

  WhichKey = { fg = c.red },
  WhichKeyDesc = { fg = c.blue },
  WhichKeyGroup = { fg = c.orange },
  WhichKeySeparator = { fg = p.base03 },

  markdownH1 = { fg = c.red },
  markdownH2 = { fg = c.orange },
  markdownH3 = { fg = c.yellow },
  markdownH4 = { fg = c.green },
  markdownH5 = { fg = c.blue },
  markdownH6 = { fg = c.purple },
  ["@markup.link.url.markdown"] = { fg = c.cyan, underline = true },
  ["@markup.list.markdown"] = { fg = c.red },
  ["@markup.raw.markdown_inline"] = { fg = c.green },
  --
  -- -- LSP
  ["@constructor"] = { fg = c.yellow },
  ["@keyword"] = { fg = c.purple },
  ["@keyword.return"] = { fg = c.purple },
  ["@lsp.type.variable"] = { fg = c.cyan },
  ["@module"] = { fg = c.yellow },
  ["@property"] = { fg = c.cyan },
  ["@type.builtin.go"] = { fg = c.yellow },
  ["@variable.member.go"] = { fg = c.cyan },
  ["@variable.parameter"] = { fg = c.red },
}

for group, args in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, args)
end
