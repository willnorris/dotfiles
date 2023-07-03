-- Git related plugins
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add          = { text = "+" },
        change       = { text = "~" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
        untracked    = { text = "┆" },
      },
    }
  },

  "junegunn/gv.vim",    -- Git commit browser
  "tpope/vim-git",      -- Vim runtime files for git
  "tpope/vim-fugitive", -- Vim interface to git
  "tpope/vim-rhubarb",  -- GitHub support for vim-fugitive

  {
    "ruifm/gitlinker.nvim", -- Shareable permalinks to git hosts
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

          -- keymaps to scroll diff window
          vim.keymap.set({ "n", "i" }, "<A-j>", "<Plug>(committia-scroll-diff-down)",
            { buffer = 0, desc = "scroll diff down" })
          vim.keymap.set({ "n", "i" }, "<A-k>", "<Plug>(committia-scroll-diff-up)",
            { buffer = 0, desc = "scroll diff up" })
          vim.keymap.set({ "n", "i" }, "<A-f>", "<Plug>(committia-scroll-diff-down-half)",
            { buffer = 0, desc = "scroll diff down half" })
          vim.keymap.set({ "n", "i" }, "<A-b>", "<Plug>(committia-scroll-diff-up-half)",
            { buffer = 0, desc = "scroll diff up half" })
        end,
      }
    end,
  },
}
