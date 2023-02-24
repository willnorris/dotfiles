local M = {}

M.gitsigns = {
  setup = function()
    vim.api.nvim_create_autocmd({ "BufRead" }, {
      callback = function()
        vim.fn.system("git rev-parse 2>/dev/null " .. vim.fn.expand("%:p:h"))
        if vim.v.shell_error == 0 then
          vim.schedule(function()
            require("packer").loader("gitsigns.nvim")
          end)
        end
      end,
    })
  end,
  config = function()
    local gitsigns = require("gitsigns")
    gitsigns.setup({
      signs = {
        add = { text = "+" },
        change = { text = "~" },
      },
      on_attach = function(bufnr)
        vim.keymap.set("n", "]d", function()
          if vim.wo.diff then
            return "]d"
          end
          vim.schedule(function()
            gitsigns.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, buffer = bufnr })

        vim.keymap.set("n", "[d", function()
          if vim.wo.diff then
            return "[d"
          end
          vim.schedule(function()
            gitsigns.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, buffer = bufnr })

        vim.keymap.set("n", "yohs", gitsigns.toggle_signs, { desc = "toggle git signs" })
        vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { desc = "git stage hunk" })
        vim.keymap.set("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "undo add hunk" })
        vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, { desc = "git reset hunk" })
        vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, { desc = "git preview hunk" })
      end,
    })
  end,
}

M.committia = {
  config = function()
    vim.g.committia_hooks = {
      edit_open = function(info)
        vim.wo.spell = true

        -- keymaps to scroll diff window
        vim.keymap.set(
          { "n", "i" },
          "<A-j>",
          "<Plug>(committia-scroll-diff-down)",
          { buffer = 0, desc = "scroll diff down" }
        )
        vim.keymap.set(
          { "n", "i" },
          "<A-k>",
          "<Plug>(committia-scroll-diff-up)",
          { buffer = 0, desc = "scroll diff up" }
        )
        vim.keymap.set(
          { "n", "i" },
          "<A-f>",
          "<Plug>(committia-scroll-diff-down-half)",
          { buffer = 0, desc = "scroll diff down half" }
        )
        vim.keymap.set(
          { "n", "i" },
          "<A-b>",
          "<Plug>(committia-scroll-diff-up-half)",
          { buffer = 0, desc = "scroll diff up half" }
        )
      end,
    }
  end,
}

return M
