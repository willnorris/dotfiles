vim.cmd [[
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
]]

vim.cmd [[
augroup colorextend
  autocmd!
  let colors = onedark#GetColors()
  let none = { "gui": "NONE", "cterm": "NONE", "cterm16": "NONE" }
  autocmd ColorScheme * call onedark#extend_highlight("DiffChange", {"gui": "NONE", "cterm": "NONE"})
  autocmd ColorScheme * call onedark#set_highlight("MatchParen", {"cterm": "NONE", "bg": colors.comment_grey})
  autocmd ColorScheme * call onedark#set_highlight("NormalFloat", {"fg": colors.white})
  autocmd ColorScheme * call onedark#extend_highlight("Pmenu", {"bg": none})

  autocmd ColorScheme * call onedark#set_highlight("FocusedSymbol", {"bg": colors.visual_grey})
  autocmd ColorScheme * call onedark#set_highlight("SymbolsOutlineConnector", {"fg": colors.black})
  autocmd ColorScheme * call onedark#set_highlight("LspReferenceRead", {"fg": colors.cyan, "gui": "underline", "cterm": "underline"})
  autocmd ColorScheme * call onedark#set_highlight("LspReferenceWrite", {"fg": colors.cyan, "gui": "underline", "cterm": "underline"})
  autocmd ColorScheme * call onedark#set_highlight("LspCodeLens", {"fg": colors.comment_grey})
  autocmd ColorScheme * call onedark#set_highlight("LspCodeLensSeparator", {"fg": colors.comment_grey})
  autocmd ColorScheme * call onedark#set_highlight("TreesitterContext", {"bg": colors.black})

  autocmd ColorScheme * call onedark#set_highlight("NvimTreeIndentMarker", {"fg": colors.black})

  autocmd ColorScheme * call onedark#set_highlight("NeotestIndent", {"fg": colors.black})
  autocmd ColorScheme * call onedark#set_highlight("NeotestExpandMarker", {"fg": colors.black})
augroup END
]]

vim.g.onedark_termcolors = 16
vim.cmd [[silent! colorscheme onedark]]

vim.opt.hlsearch = true
vim.opt.colorcolumn = "+1" -- display column at edge of textwidth

vim.cmd [[
  " nvim-cmp
  hi link CmpItemAbbrDeprecated Comment
  hi link CmpItemAbbrMatch Special
  hi link CmpItemAbbrMatchFuzzy Special
  hi link CmpItemKind Type
  hi link CmpItemMenu Label
]]

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('YankHighlight', {}),
  callback = function() vim.highlight.on_yank({ timeout = 150 }) end,
})
