local gitsigns = require("gitsigns")

gitsigns.setup {
  signs = {
    add = { text = "+" },
    change = { text = "~" },
  },
  on_attach = function(bufnr)
    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gitsigns.next_hunk() end)
      return '<Ignore>'
    end, { expr = true, buffer = bufnr })

    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gitsigns.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true, buffer = bufnr })

    vim.keymap.set("n", "yogs", gitsigns.toggle_signs, { desc = "toggle git signs" })
    vim.keymap.set("n", "<leader>ga", gitsigns.stage_hunk, { desc = "git add hunk" })
    vim.keymap.set("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "undo add hunk" })
    vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, { desc = "git reset hunk" })
    vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, { desc = "git preview hunk" })
  end,
}
