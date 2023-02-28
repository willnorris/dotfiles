-- Git related plugins
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add          = { text = "+" },
        change       = { text = "~" },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      on_attach = function(buffer)
        local gitsigns = package.loaded.gitsigns
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map("n", "yohs", gitsigns.toggle_signs, "Toggle git signs")
        map("n", "]h", gitsigns.next_hunk, "Next hunk")
        map("n", "[h", gitsigns.prev_hunk, "Prev hunk")
        map({ "n", "v" }, "<leader>hs", gitsigns.stage_hunk, "Stage hunk")
        map({ "n", "v" }, "<leader>hr", gitsigns.reset_hunk, "Reset hunk")
        map("n", "<leader>hu", gitsigns.undo_stage_hunk, "Undo stage hunk")
        map("n", "<leader>hS", gitsigns.stage_buffer, "Stage buffer")
        map("n", "<leader>hR", gitsigns.reset_buffer, "Stage buffer")
        map("n", "<leader>hp", gitsigns.preview_hunk, "Preview hunk")
        map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, "Blame line")
        map("n", "<leader>ghd", gitsigns.diffthis, "Diff this")
        map("n", "<leader>ghD", function() gitsigns.diffthis("~") end, "Diff this ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    }
  },
  "junegunn/gv.vim", -- Git commit browser
  "tpope/vim-git", -- Vim runtime files for git
  "tpope/vim-fugitive", -- Vim interface to git
  "tpope/vim-rhubarb", -- GitHub support for vim-fugitive
  "rhysd/git-messenger.vim", -- commit message under cursor
  {
    "ruifm/gitlinker.nvim", -- Shareable permalinks to git hosts
    keys = "<leader>gy",
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
