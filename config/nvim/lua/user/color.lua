local onedark = require("onedark")
local colors = onedark.get_colors()
local none = { gui = "NONE", cterm = "NONE", cterm16 = "NONE" }

vim.g.onedark_color_overrides = {
  background = none
}

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  callback = function()
    onedark.extend_highlight("Normal", { bg = none })
    onedark.extend_highlight("DiffChange", { gui = none.gui, cterm = none.cterm })
    onedark.set_highlight("MatchParen", { bg = colors.comment_grey, gui = none.gui, cterm = none.cterm })
    onedark.set_highlight("NormalFloat", { fg = colors.white })
    onedark.set_highlight("FloatTitle", { fg = colors.comment_grey })
    onedark.set_highlight("FloatBorder", { fg = colors.comment_grey })
    onedark.extend_highlight("Pmenu", { bg = none })
    onedark.extend_highlight("Folded", { fg = colors.comment_grey, bg = colors.black })

    onedark.set_highlight("FocusedSymbol", { bg = colors.visual_grey })
    onedark.set_highlight("SymbolsOutlineConnector", { fg = colors.black })
    onedark.set_highlight("LspCodeLens", { fg = colors.comment_grey })
    onedark.set_highlight("LspCodeLensSeparator", { fg = colors.comment_grey })
    onedark.set_highlight("TreesitterContext", { bg = colors.black })

    onedark.set_highlight("NvimTreeIndentMarker", { fg = colors.black })

    onedark.set_highlight("NeotestIndent", { fg = colors.black })
    onedark.set_highlight("NeotestExpandMarker", { fg = colors.black })

    onedark.set_highlight("Twilight", { fg = colors.visual_grey })

    onedark.set_highlight("SignatureMarkText", { fg = colors.red })
    onedark.set_highlight("SignatureMarkerText", { fg = colors.green })

    onedark.set_highlight("NeotestFailed", { fg = colors.red })
    onedark.set_highlight("NeotestPassed", { fg = colors.green })
    onedark.set_highlight("NeotestRunning", { fg = colors.yellow })
    onedark.set_highlight("NeotestDir", { fg = colors.blue })
    onedark.set_highlight("NeotestCyan", { fg = colors.cyan })
    onedark.set_highlight("NeotestAdapterName", { fg = colors.red })

    vim.cmd [[
      hi link LspReferenceRead CursorLine
      hi link LspReferenceWrite CursorLine
      hi link LspReferenceText CursorLine

      " nvim-cmp
      hi link CmpItemAbbrDeprecated Comment
      hi link CmpItemAbbrMatch Special
      hi link CmpItemAbbrMatchFuzzy Special
      hi link CmpItemKind Type
      hi link CmpItemMenu Label
    ]]
  end,
})

vim.o.termguicolors = true
vim.cmd [[silent! colorscheme onedark]]

vim.opt.hlsearch = true
vim.opt.colorcolumn = "+1" -- display column at edge of textwidth

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('YankHighlight', {}),
  callback = function() vim.highlight.on_yank({ timeout = 150 }) end,
})

vim.cmd [[
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
]]
