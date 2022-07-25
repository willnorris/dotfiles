vim.g.committia_hooks = {
  edit_open = function(info)
    vim.wo.spell = true

    -- if commit message is empty, start in insert mode
    if info.vcs == "git" and vim.fn.getline(1) == "" then
      vim.cmd("startinsert")
    end

    -- keymaps to scroll diff window
    vim.keymap.set({ "n", "i" }, "<A-j>",
      "<Plug>(committia-scroll-diff-down)", { buffer = 0, desc = "scroll diff down" })
    vim.keymap.set({ "n", "i" }, "<A-k>",
      "<Plug>(committia-scroll-diff-up)", { buffer = 0, desc = "scroll diff up" })
    vim.keymap.set({ "n", "i" }, "<A-f>",
      "<Plug>(committia-scroll-diff-down-half)", { buffer = 0, desc = "scroll diff down half" })
    vim.keymap.set({ "n", "i" }, "<A-b>",
      "<Plug>(committia-scroll-diff-up-half)", { buffer = 0, desc = "scroll diff up half" })
  end,
}
