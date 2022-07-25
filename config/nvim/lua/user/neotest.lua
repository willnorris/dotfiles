local neotest = require("neotest")

neotest.setup {
  adapters = {
    require("neotest-go"),
    require("neotest-python"),
  },
  icons = {
    expanded = "┐",
    final_child_prefix = "└",
  },
  output = {
    open_on_run = false,
  }
}

vim.diagnostic.config({
  signs = true,
  virtual_text = true,
}, vim.api.nvim_create_namespace("neotest"))

local wk_ok, wk = pcall(require, "which-key")
if wk_ok then wk.register({ ["<leader>t"] = { name = "+testing" } }) end

vim.keymap.set("n", "<leader>tt", neotest.run.run, {desc="run nearest test"})
vim.keymap.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, {desc="test file"})
vim.keymap.set("n", "<leader>tl", neotest.run.run_last, {desc="run last test"})
vim.keymap.set("n", "<leader>ts", neotest.summary.toggle, {desc="show test summary"})
vim.keymap.set("n", "<leader>to", neotest.output.open, {desc="show test output"})
vim.keymap.set("n", "<leader>tw", function()
  neotest.output.open({ open_win = function() vim.cmd("bel split") end })
end, {desc="show test window"})

