-- onedark: don't set a background color, just use terminal's background
vim.cmd [[
  if (has("autocmd") && !has("gui_running"))
    augroup colorset
      autocmd!
      let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
      autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white })
    augroup END
  endif
]]

vim.g.onedark_termcolors = 16
vim.cmd [[silent! colorscheme onedark]]

vim.opt.hlsearch = true
vim.opt.colorcolumn = "+1" -- display column at edge of textwidth

vim.cmd [[
  highlight Comment ctermfg=8
  highlight SpecialComment ctermfg=8
  highlight ColorColumn ctermbg=black
  highlight SignColumn ctermbg=NONE
  highlight LineNr ctermbg=NONE ctermfg=8
  highlight DiffChange cterm=NONE
  highlight SpellBad cterm=undercurl
  highlight MatchParen ctermbg=8
  highlight NormalFloat ctermfg=15 ctermbg=NONE
  highlight Visual ctermbg=0
  highlight Pmenu ctermfg=15 ctermbg=NONE
  highlight FocusedSymbol ctermfg=NONE ctermbg=8
  highlight SymbolsOutlineConnector ctermfg=8
  highlight LspReferenceRead ctermfg=red cterm=underline
  highlight LspReferenceWrite ctermfg=red cterm=underline
  highlight gitcommitComment ctermfg=8
]]
