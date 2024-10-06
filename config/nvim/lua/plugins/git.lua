-- Git related plugins
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
    },
  },

  "junegunn/gv.vim",    -- Git commit browser
  "tpope/vim-git",      -- Vim runtime files for git
  "tpope/vim-fugitive", -- Vim interface to git
  "tpope/vim-rhubarb",  -- GitHub support for vim-fugitive

  {
    "ruifm/gitlinker.nvim", -- Shareable permalinks to git hosts
    event = "VeryLazy",
    keys = {
      { "<leader>gy", "", mode = { "n", "v" }, desc = "copy sharable git URL" },
    },
    config = true,
  },
  {
    "rhysd/committia.vim",
    config = function()
      vim.g.committia_hooks = {
        edit_open = function(_)
          vim.wo.spell = true

          local mod = require("util").mod

          -- keymaps to scroll diff window
          vim.keymap.set({ "n", "i" }, mod("j"), "<Plug>(committia-scroll-diff-down)",
            { buffer = 0, desc = "scroll diff down" })
          vim.keymap.set({ "n", "i" }, mod("k"), "<Plug>(committia-scroll-diff-up)",
            { buffer = 0, desc = "scroll diff up" })
          vim.keymap.set({ "n", "i" }, mod("f"), "<Plug>(committia-scroll-diff-down-half)",
            { buffer = 0, desc = "scroll diff down half" })
          vim.keymap.set({ "n", "i" }, mod("b"), "<Plug>(committia-scroll-diff-up-half)",
            { buffer = 0, desc = "scroll diff up half" })
        end,
      }
    end,
  },
}
