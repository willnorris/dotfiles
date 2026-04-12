C.later(function()
  vim.pack.add({"https://github.com/lewis6991/gitsigns.nvim"})
  require("gitsigns").setup({
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    signs_staged = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
      end

      -- stylua: ignore start
      map("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gs.nav_hunk("next")
        end
      end, "Next Hunk")
      map("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gs.nav_hunk("prev")
        end
      end, "Prev Hunk")
      map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
      map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
      map({ "n", "x" }, "<Leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      map({ "n", "x" }, "<Leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      map("n", "<Leader>ghS", gs.stage_buffer, "Stage Buffer")
      map("n", "<Leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<Leader>ghR", gs.reset_buffer, "Reset Buffer")
      map("n", "<Leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
      map("n", "<Leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
      map("n", "<Leader>ghB", function() gs.blame() end, "Blame Buffer")
      map("n", "<Leader>ghd", gs.diffthis, "Diff This")
      map("n", "<Leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
    end,
  })

  table.insert(C.keymap_groups, {
    mode = { "n", "v" },
    { "<Leader>g", group = "git" },
    { "<Leader>gh", group = "hunks" },
  })
end)

C.later(function()
  vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/ruifm/gitlinker.nvim"
  })
  local g = require("gitlinker")
  g.setup({mappings = nil})
  for _, mode in pairs({"n", "v"}) do
    vim.keymap.set(mode, "<Leader>gy", function() g.get_buf_range_url(mode) end, { noremap = true, desc = "Copy git URL" })
  end
end)

C.later(function()
  vim.pack.add({"https://github.com/rhysd/committia.vim"})
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
end)
