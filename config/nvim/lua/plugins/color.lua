return {
  "navarasu/onedark.nvim",
  priority = 1000,
  config = function ()
    local onedark = require("onedark")
    onedark.setup {
      transparent = true,
      ending_tildes = true,

      code_style = {
        comments = "none",
      },

      highlights = {
        Folded = { bg = "$bg0" },
        NormalFloat = { bg = "$bg0" },
        FloatBorder = { bg = "$bg0" },

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
      },
    }
    onedark.load()

    vim.opt.termguicolors = true
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
  end,
}
