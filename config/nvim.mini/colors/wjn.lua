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
    -- only enable specific plugins
    default = false,
    ["nvim-mini/mini.nvim"] = true,
    ["folke/trouble.nvim"] = true,
    ["folke/which-key.nvim"] = true,
    ["lewis6991/gitsigns.nvim"] = true,
  },
})
vim.g.colors_name = "wjn"

local c = {
  grey    = p.base03,
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
  CursorLineNr = { fg = p.base05 },
  CursorLineSign = {},
  FloatBorder = { fg = p.base03, bg = p.base01 },
  FloatTitle = { fg = p.base05, bg = p.base01 },
  LineNr = { fg = p.base03 },
  Normal = { fg = "fg" }, -- remove bg to make theme transparent
  SignColumn = { fg = p.base03 },
  WinSeparator = { fg = p.base02 },

  -- standard syntax
  Character = { fg = c.orange },
  Constant = { fg = c.cyan },
  Delimiter = { fg = p.base05 },
  Error = { fg = c.red },
  Exception = { fg = c.red },
  Include = { fg = c.purple },
  Label = { fg = c.purple },
  Operator = { fg = c.purple },
  PreCondit = { fg = c.purple },
  PreProc = { fg = c.purple },
  Repeat = { fg = c.purple },
  Special = { fg = c.red },
  SpecialChar = { fg = c.red },
  Statement = { fg = c.purple },
  Structure = { fg = c.yellow },
  Tag = { fg = c.green },
  Todo = { fg = c.red },

  GitSignsAdd = { link = "Added" },
  GitSignsChange = { link = "Changed" },
  GitSignsDelete = { link = "Removed" },
  DiffAdd = { link = "Added" },
  DiffChange = { link = "Changed" },
  DiffDelete = { link = "Removed" },
  MiniDiffSignAdd = { link = "Added" },
  MiniDiffSignChange = { link = "Changed" },
  MiniDiffSignDelete = { link = "Removed" },

  SnacksIndent = { fg = p.base01 },
  SnacksIndentScope = { fg = p.base03 },

  SnacksInputNormal = {},
  SnacksInputBorder = { fg = p.base03 },
  SnacksInputTitle = { fg = p.base04 },
  SnacksPicker = { fg = p.base05 },
  SnacksPickerBorder = { fg = p.base03 },
  SnacksPickerIcon = { fg = c.red },
  SnacksPickerPrompt = { fg = c.red },
  SnacksPickerInputTitle = { fg = "fg" },

  MiniTablineFill = { bg = p.base01 },
  MiniTablineVisible = { bg = p.base01 },
  MiniTablineHidden = { bg = p.base01 },

  MiniStarterSection = { fg = c.blue },
  MiniStarterItemBullet = { fg = p.base02 },

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
  ["@markup.link.label.markdown"] = { fg = c.orange, underline = true },
  ["@markup.link.markdown_inline"] = { fg = c.blue, underline = true },
  ["@markup.link.label.markdown_inline"] = { fg = c.orange, underline = true },
  ["@markup.link.url.markdown_inline"] = { fg = c.cyan, underline = true },
  ["@markup.list.markdown"] = { fg = c.red },
  ["@markup.raw.markdown_inline"] = { fg = c.green },
  ["@markup.quote"] = { fg = c.grey, italic = true },

  ["@tag"] = { fg = c.purple },
  ["@tag.attribute"] = { fg = c.yellow },

  ["@property"] = { fg = c.cyan },
  ["@variable.member"] = { link = "@property" },
}

for group, args in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, args)
end
