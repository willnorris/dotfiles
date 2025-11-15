local keymap = vim.keymap.set
local mod = require("util").mod

vim.o.winblend = 0 -- disable transparency of floating windows

require("snacks").setup({
  gh = {},
  picker = {
    layout = {
      preset = "ivy",
    },
    sources = {
      gh_issue = {},
      gh_pr = {},
    },
    win = {
      input = {
        keys = {
          ["<C-x>"] = { "trouble_open", mode = { "n", "i" }, },

          ["<C-c>"] = { "close", mode = { "n", "i" }, },

          ["<C-p>"] = { "history_back", mode = { "i", "n" } },
          ["<C-n>"] = { "history_forward", mode = { "i", "n" } },

          ["<C-f>"] = { "list_scroll_down", mode = { "i", "n" } },
          ["<C-b>"] = { "list_scroll_up", mode = { "i", "n" } },

          [mod("j")] = { "preview_down", mode = { "i", "n" } },
          [mod("k")] = { "preview_up", mode = { "i", "n" } },
          [mod("f")] = { "preview_scroll_down", mode = { "i", "n" } },
          [mod("b")] = { "preview_scroll_up", mode = { "i", "n" } },
        },
      },
      list = {
        keys = {
          ["<C-x>"] = "trouble_open",

          ["<C-f>"] = "list_scroll_down",
          ["<C-b>"] = "list_scroll_up",

          [mod("j")] = "preview_down",
          [mod("k")] = "preview_up",
          [mod("f")] = "preview_scroll_down",
          [mod("b")] = "preview_scroll_up",
        },
      },
    },
    actions = {
      preview_down = function(p)
        vim.api.nvim_win_call(p.preview.win.win, function() vim.cmd("normal! " .. Snacks.util.keycode("<C-e>")) end)
      end,
      preview_up = function(p)
        vim.api.nvim_win_call(p.preview.win.win, function() vim.cmd("normal! " .. Snacks.util.keycode("<C-y>")) end)
      end,
    },
  },
})
keymap("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Find Files (Root Dir)" })
keymap("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
keymap("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep" })
keymap("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
keymap("n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "Notification History" })
keymap("n", "<leader>e", function() Snacks.picker.explorer() end, { desc = "File Explorer" })
-- find
keymap("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
keymap("n", "<leader>fB", function() Snacks.picker.buffers({ hidden = true, nofile = true }) end, { desc = "Buffers" })
keymap("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find Config Files" })
keymap("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find Files" })
keymap("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find Files (git-files)" })
keymap("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })
keymap("n", "<leader>fR", function() Snacks.picker.recent({ filter = { cwd = true }}) end, { desc = "Recent (cwd)" })
keymap("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Projects" })
-- git
keymap("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git Diff (hunks)" })
keymap("n", "<leader>gD", function() Snacks.picker.git_diff({ base = "origin", group = true }) end, { desc = "Git Diff (origin)" })
keymap("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
keymap("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" })
keymap("n", "<leader>gi", function() Snacks.picker.gh_issue() end, { desc = "GitHub Issues (open)" })
keymap("n", "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, { desc = "GitHub Issues (all)" })
keymap("n", "<leader>gp", function() Snacks.picker.gh_pr() end, { desc = "GitHub Pull Requests (open)" })
keymap("n", "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, { desc = "GitHub Pull Requests (all)" })
-- Grep
keymap("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
keymap("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
keymap("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep" })
keymap("n", "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Grep Word" })
-- search
keymap("n", '<leader>s"', function() Snacks.picker.registers() end, { desc = "Registers" })
keymap("n", '<leader>s/', function() Snacks.picker.search_history() end, { desc = "Search History" })
keymap("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "Autocmds" })
keymap("n", "<leader>sc", function() Snacks.picker.command_history() end, { desc = "Command History" })
keymap("n", "<leader>sC", function() Snacks.picker.commands() end, { desc = "Commands" })
keymap("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
keymap("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
keymap("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
keymap("n", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "Highlights" })
keymap("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "Icons" })
keymap("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "Jumps" })
keymap("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
keymap("n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "Location List" })
keymap("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "Man Pages" })
keymap("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "Marks" })
keymap("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
keymap("n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "Resume" })
keymap("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "Undotree" })
-- ui
keymap("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })

keymap("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
keymap("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
keymap("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
keymap("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
keymap("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
keymap("n", "gai", function() Snacks.picker.lsp_incoming_calls() end, { desc = "C[a]lls Incoming" })
keymap("n", "gao", function() Snacks.picker.lsp_outgoing_calls() end, { desc = "C[a]lls Outgoing" })
keymap("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
keymap("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })

vim.pack.add({ "https://github.com/folke/which-key.nvim" })
require("which-key").setup({
  preset = "classic",
  icons = {
    separator = "",
    mappings = false,
    rules = false,
  },
  win = {
    border = "rounded",
  },
})

require("mini.statusline").setup({
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 9999 })
      local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
      local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
      local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })
      local location      = '%l:%v'

      search = (string.len(search)>0 and '['..search..']' or search)

      return MiniStatusline.combine_groups({
        { hl = mode_hl,                 strings = { mode } },
        { hl = 'MiniStatuslineDevinfo', strings = { diagnostics, lsp } },
        '%<', -- Mark general truncate point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=', -- End left alignment
        { hl = 'MiniStatuslineFileinfo', strings = { search } },
        { hl = mode_hl,                  strings = { location } },
      })
    end,
  },
})
require("mini.tabline").setup()

require("mini.starter").setup()
require("mini.sessions").setup()
require("mini.notify").setup()
