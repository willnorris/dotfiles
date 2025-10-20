-- wjn is my custom mini.base16 color scheme.
-- It's really just a onedark color palette with custom higlights.
-- I'll eventually add a light mode as well.

require('mini.base16').setup({
  palette = {
    base00 = "#282c34",
    base01 = "#353b45",
    base02 = "#3e4451",
    base03 = "#545862",
    base04 = "#565c64",
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
  },
  use_cterm = true,
})
vim.g.colors_name = 'wjn'
vim.cmd [[
  highlight Normal ctermbg=NONE guibg=NONE
  highlight NormalNC ctermbg=NONE guibg=NONE
  highlight LineNr ctermbg=NONE guibg=NONE
  highlight SignColumn ctermbg=NONE guibg=NONE
  highlight MiniDiffSignAdd ctermbg=NONE guibg=NONE
  highlight MiniDiffSignChange ctermbg=NONE guibg=NONE
  highlight MiniDiffSignDelete ctermbg=NONE guibg=NONE
]]
