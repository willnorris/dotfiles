local keymap = vim.keymap.set
local mod = require("util").mod

-- restore cursor position
C.now(function()
  C.autocmd("BufWinEnter", "*",
    function() vim.cmd([[silent! normal! g`"zv']]) end,
    "return cursor to where it was last time closing the file")
end)

C.later(function()
  local hipatterns = require("mini.hipatterns")
  hipatterns.setup({
    highlighters = {
      -- Highlight hex color string (#aabbcc) with that color as a background
      hex_color = hipatterns.gen_highlighter.hex_color(),
      -- Add support for #rrggbbaa style colors patterns.
      -- Neovim doesn't support color transparency, so just the #rrggbb is rendered.
      hex_color_alpha = {
        pattern = "#%x%x%x%x%x%x%x%x%f[%X]",
        group = function(_, match)
          return hipatterns.compute_hex_color_group(match:sub(1, 7), "bg")
        end,
        extmark_opts = { priority = 2000 },
      },

    },
  })
end)

-- must be before snacks.nvim
C.later(function()
  vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/folke/todo-comments.nvim"
  })

  require("todo-comments").setup({
    highlight = {
      pattern = {
        [[.*<(KEYWORDS)\s*:]],
        [[.*<(KEYWORDS)\(.*\)\s*:]], -- handle KEYWORD(name):
      },
      keyword = "fg",
      after = "",
    },
    search = {
      pattern = [[\b(KEYWORDS)(\(.*\))?:]],
    },
  })
end)

C.later(function()
  vim.pack.add({ "https://github.com/folke/snacks.nvim" })
  local snacks = require("snacks")
  vim.g.snacks_animate = false
  snacks.setup({
    gh = {},
    indent = {},
    input = {
      icon = "",
      win = {
        title_pos = "left",
        relative = "cursor",
        row = -3,
        col = 0,
        width = 30,
        keys = {
          ctrl_c = { "<C-c>", { "cmp_close", "cancel" }, mode = { "n", "i" } },
        },
      },
    },
    picker = {
      layout = {
        -- Copy of "ivy" preset with title moved into "input" window instead of root
        layout = {
          box = "vertical",
          backdrop = false,
          row = -1,
          width = 0,
          height = 0.4,
          border = "none",
          { win = "input", height = 1, border = "top_bottom", title = " {title} {live} {flags}", title_pos = "left" },
          {
            box = "horizontal",
            { win = "list", border = "none" },
            { win = "preview", title = "{preview}", width = 0.6, border = "left" },
          },
        },
      },
      sources = {
        gh_issue = {},
        gh_pr = {},
      },
      win = {
        input = {
          keys = {
            ["<C-t>"] = { "trouble_open", mode = { "n", "i" }, },

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
            ["<C-t>"] = "trouble_open",

            ["<C-f>"] = "list_scroll_down",
            ["<C-b>"] = "list_scroll_up",

            [mod("j")] = "preview_down",
            [mod("k")] = "preview_up",
            [mod("f")] = "preview_scroll_down",
            [mod("b")] = "preview_scroll_up",
          },
        },
      },
      actions = vim.tbl_deep_extend("force",
        require("trouble.sources.snacks").actions,
        {
          preview_down = function(p)
            vim.api.nvim_win_call(p.preview.win.win, function() vim.cmd("normal! " .. snacks.util.keycode("<C-e>")) end)
          end,
          preview_up = function(p)
            vim.api.nvim_win_call(p.preview.win.win, function() vim.cmd("normal! " .. snacks.util.keycode("<C-y>")) end)
          end,
        })
    },
    toggle = {},
    dim = {},
    zen = {
      toggles = {
        diagnostics = false,
        indent = false,
      },
      on_open = function()
        vim.opt.signcolumn = "no"
        vim.opt.number = false
      end,
      win = {
        backrop = { transparent = false },
      },
      zoom = {
        win = {
          --backdrop = true,
          backrop = { transparent = false },
          width = 0,
        },
      },
    },
  })
  C.nmap("<Leader><space>", snacks.picker.smart, "Find Files (Root Dir)")
  C.nmap("<Leader>,", snacks.picker.buffers, "Buffers")
  C.nmap("<Leader>/", snacks.picker.grep, "Grep")
  C.nmap("<Leader>:", snacks.picker.command_history, "Command History")
  C.nmap("<Leader>n", snacks.picker.notifications, "Notification History")
  C.nmap("<Leader>e", snacks.picker.explorer, "File Explorer")
  -- find
  C.nmap("<Leader>fb", snacks.picker.buffers, "Buffers")
  C.nmap("<Leader>fB", function() snacks.picker.buffers({ hidden = true, nofile = true }) end, "Buffers")
  C.nmap("<Leader>fc", function() snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, "Find Config Files")
  C.nmap("<Leader>ff", snacks.picker.files, "Find Files")
  C.nmap("<Leader>fg", snacks.picker.git_files, "Find Files (git-files)")
  C.nmap("<Leader>fr", snacks.picker.recent, "Recent")
  C.nmap("<Leader>fR", function() snacks.picker.recent({ filter = { cwd = true } }) end, "Recent (cwd)")
  C.nmap("<Leader>fp", snacks.picker.projects, "Projects")
  -- git
  C.nmap("<Leader>gd", snacks.picker.git_diff, "Git Diff (hunks)")
  C.nmap("<Leader>gD", function() snacks.picker.git_diff({ base = "origin", group = true }) end, "Git Diff (origin)")
  C.nmap("<Leader>gs", snacks.picker.git_status, "Git Status")
  C.nmap("<Leader>gS", snacks.picker.git_stash, "Git Stash")
  C.nmap("<Leader>gi", snacks.picker.gh_issue, "GitHub Issues (open)")
  C.nmap("<Leader>gI", function() snacks.picker.gh_issue({ state = "all" }) end, "GitHub Issues (all)")
  C.nmap("<Leader>gp", snacks.picker.gh_pr, "GitHub Pull Requests (open)")
  C.nmap("<Leader>gP", function() snacks.picker.gh_pr({ state = "all" }) end, "GitHub Pull Requests (all)")
  -- Grep
  C.nmap("<Leader>sb", snacks.picker.lines, "Buffer Lines")
  C.nmap("<Leader>sB", snacks.picker.grep_buffers, "Grep Open Buffers")
  C.nmap("<Leader>sg", snacks.picker.grep, "Grep")
  C.nmap("<Leader>sw", snacks.picker.grep_word, "Grep Word")
  -- search
  C.nmap('<Leader>s"', snacks.picker.registers, "Registers")
  C.nmap("<Leader>s/", snacks.picker.search_history, "Search History")
  C.nmap("<Leader>sa", snacks.picker.autocmds, "Autocmds")
  C.nmap("<Leader>sc", snacks.picker.command_history, "Command History")
  C.nmap("<Leader>sC", snacks.picker.commands, "Commands")
  C.nmap("<Leader>sd", snacks.picker.diagnostics, "Diagnostics")
  C.nmap("<Leader>sD", snacks.picker.diagnostics_buffer, "Buffer Diagnostics")
  C.nmap("<Leader>sh", snacks.picker.help, "Help Pages")
  C.nmap("<Leader>sH", snacks.picker.highlights, "Highlights")
  C.nmap("<Leader>si", snacks.picker.icons, "Icons")
  C.nmap("<Leader>sj", snacks.picker.jumps, "Jumps")
  C.nmap("<Leader>sk", snacks.picker.keymaps, "Keymaps")
  C.nmap("<Leader>sl", snacks.picker.loclist, "Location List")
  C.nmap("<Leader>sM", snacks.picker.man, "Man Pages")
  C.nmap("<Leader>sm", snacks.picker.marks, "Marks")
  C.nmap("<Leader>sq", snacks.picker.qflist, "Quickfix List")
  C.nmap("<Leader>sR", snacks.picker.resume, "Resume")
  C.nmap("<Leader>su", snacks.picker.undo, "Undotree")
  -- ui
  C.nmap("<Leader>uC", snacks.picker.colorschemes, "Colorschemes")

  C.nmap("<leader>st", snacks.picker.todo_comments, "Todo")
  C.nmap("<leader>sT", function() snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end,
    "Todo/Fix/Fixme")

  C.nmap("gd", snacks.picker.lsp_definitions, "Goto Definition")
  C.nmap("gD", snacks.picker.lsp_declarations, "Goto Declaration")
  keymap("n", "gr", snacks.picker.lsp_references, { nowait = true, desc = "References" })
  C.nmap("gI", snacks.picker.lsp_implementations, "Goto Implementation")
  C.nmap("gy", snacks.picker.lsp_type_definitions, "Goto T[y]pe Definition")
  C.nmap("gai", snacks.picker.lsp_incoming_calls, "C[a]lls Incoming")
  C.nmap("gao", snacks.picker.lsp_outgoing_calls, "C[a]lls Outgoing")
  C.nmap("<Leader>ss", snacks.picker.lsp_symbols, "LSP Symbols")
  C.nmap("<Leader>sS", snacks.picker.lsp_workspace_symbols, "LSP Workspace Symbols")

  C.nmap("<Leader>cL", snacks.picker.lsp_config, "LSP Info")

  -- toggle options
  snacks.toggle.option("spell", { name = "Spelling" }):map("<Leader>us")
  snacks.toggle.option("wrap", { name = "Wrap" }):map("<Leader>uw")
  snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<Leader>uL")
  snacks.toggle.diagnostics():map("<Leader>ud")
  snacks.toggle.line_number():map("<Leader>ul")
  snacks.toggle.option("conceallevel",
    { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }):map("<Leader>uc")
  snacks.toggle.option("showtabline",
    { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" }):map("<Leader>uA")
  snacks.toggle.treesitter():map("<Leader>uT")
  snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<Leader>ub")
  snacks.toggle.dim():map("<Leader>uD")
  snacks.toggle.animate():map("<Leader>ua")
  snacks.toggle.indent():map("<Leader>ug")
  snacks.toggle.scroll():map("<Leader>uS")
  snacks.toggle.profiler():map("<Leader>dpp")
  snacks.toggle.profiler_highlights():map("<Leader>dph")
  snacks.toggle.zen():map("<Leader>uz")

  if vim.lsp.inlay_hint then
    snacks.toggle.inlay_hints():map("<Leader>uh")
  end

  -- global and buffer toggles for autoformat on save (used by conform.format_on_save)
  snacks.toggle({
    name = "Auto Format (Global)",
    get = function()
      return vim.g.autoformat == nil or vim.g.autoformat
    end,
    set = function(state)
      vim.g.autoformat = state
      vim.b.autoformat = nil
    end,
  }):map("<Leader>uf")
  snacks.toggle({
    name = "Auto Format (Buffer)",
    get = function()
      local buf = vim.api.nvim_get_current_buf()
      if buf ~= nil then
        return vim.b[buf].autoformat
      else
        return vim.g.autoformat == nil or vim.g.autoformat
      end
    end,
    set = function(state)
      vim.b.autoformat = state
    end,
  }):map("<Leader>uF")

  snacks.words.enable()
  C.nmap("<C-n>", function() snacks.words.jump(vim.v.count1) end, "Next reference")
  C.nmap("<C-p>", function() snacks.words.jump(-vim.v.count1) end, "Prev reference")
end)

C.later(function()
  vim.pack.add({ "https://github.com/folke/which-key.nvim" })
  local wk = require("which-key")
  wk.setup({
    preset = "classic",
    icons = {
      separator = "",
      mappings = false,
      rules = false,
    },
    spec = {
      mode = { "n", "x" },
      { "<Leader>b", group = "buffers", expand = function() return require("which-key.extras").expand.buf() end },
      { "<Leader>c", group = "code" },
      { "<Leader>f", group = "find" },
      { "<Leader>s", group = "search" },
      { "<Leader>u", group = "toggle" },
    },
    win = {
      border = "rounded",
    },
  })

  -- Register keymap groups after all other plugins have added their groups.
  C.later(function()
    wk.add(C.keymap_groups)
  end)
end)

C.now(function()
  local msl = require("mini.statusline")
  msl.setup({
    content = {
      active = function()
        local mode, mode_hl = msl.section_mode({ trunc_width = 9999 })
        local diagnostics   = msl.section_diagnostics({ trunc_width = 75 })
        local lsp           = msl.section_lsp({ trunc_width = 75 })
        local filename      = msl.section_filename({ trunc_width = 140 })
        local search        = msl.section_searchcount({ trunc_width = 75 })
        local current_mode  = vim.fn.mode()
        local location

        -- \22 matches the control character for <c-v>
        if current_mode == "\22" or current_mode == "\22s" then
          local start_line = vim.fn.line("v")
          local end_line = vim.fn.line(".")
          local height = math.abs(end_line - start_line) + 1

          local start_col = vim.fn.virtcol("v")
          local end_col = vim.fn.virtcol(".")
          local width = math.abs(end_col - start_col) + 1

          location = string.format("%dx%d", height, width)
        elseif current_mode:match("^[vVsS]") then
          local start_line = vim.fn.line("v")
          local end_line = vim.fn.line(".")
          local count = math.abs(end_line - start_line) + 1
          location = string.format("%dL", count)
        else
          location = "%l:%v"
        end

        search = (string.len(search) > 0 and "[" .. search .. "]" or search)

        return msl.combine_groups({
          { hl = mode_hl, strings = { mode } },
          { hl = "MiniStatuslineDevinfo", strings = { diagnostics, lsp } },
          "%<", -- Mark general truncate point
          { hl = "MiniStatuslineFilename", strings = { filename } },
          "%=", -- End left alignment
          { hl = "MiniStatuslineFileinfo", strings = { search } },
          { hl = mode_hl, strings = { location } },
        })
      end,
    },
  })
end)
C.now(function()
  local mtl = require("mini.tabline")
  mtl.setup({
    show_icons = false,
    -- add extra space around label name
    format = function(buf_id, label)
      return string.format(" %s ", mtl.default_format(buf_id, label))
    end
  })
end)

-- Auto-resize windows according to golden ratio
C.later(function()
  vim.pack.add({ "https://github.com/nvim-focus/focus.nvim" })
  local focus = require("focus")
  focus.setup({
    ui = {
      signcolumn = false,
    },
  })
  keymap("n", "<Leader>uv", function() focus.focus_toggle() end, { desc = "Toggle golden ration view" })

  local focus_augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

  vim.api.nvim_create_autocmd("WinEnter", {
    group = focus_augroup,
    callback = function(_)
      local ignore_buftypes = { "nofile", "prompt", "popup", "tailscale" }
      if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
        vim.b.focus_disable = true
      end
    end,
    desc = "Disable focus autoresize for BufType",
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = focus_augroup,
    callback = function(_)
      local ignore_filetypes = { "fugitive", "gitcommit", "outline", "neo-tree", "snacks_picker_list", "trouble" }
      if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
        vim.b.focus_disable = true
      end
    end,
    desc = "Disable focus autoresize for FileType",
  })
end)

C.now(function()
  local starter = require("mini.starter")
  starter.setup({
    header = "",
    footer = "",
    items = {
      starter.sections.sessions(5, true),
      starter.sections.recent_files(5, false, false),
      {
        { name = "New buffer", action = "enew", section = "Builtin actions" },
        { name = "Quit Neovim", action = "qall", section = "Builtin actions" },
      },

    },
  })
  -- add keymaps to navigate with <C-j> and <C-k>
  C.autocmd("User", "MiniStarterOpened", function(ev)
    keymap("n", "<C-j>", function() starter.update_current_item("next") end,
      { buf = ev.buf, nowait = true, silent = true })
    keymap("n", "<C-k>", function() starter.update_current_item("prev") end,
      { buf = ev.buf, nowait = true, silent = true })
  end, "")
end)

C.later(function()
  local icons = require("mini.icons")
  icons.setup({
    file = {
      [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
      ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
    },
    filetype = {
      dotenv = { glyph = "", hl = "MiniIconsYellow" },
    },
  })
  icons.mock_nvim_web_devicons()
  icons.tweak_lsp_kind()
end)

C.later(function()
  require("mini.cmdline").setup({
    autocomplete = {
      delay = 300,
    },
  })
end)

C.now(function()
  local sessions = require("mini.sessions")
  sessions.setup()

  C.nmap("<Leader>Sd", function() sessions.select("delete") end, "Delete")
  C.nmap("<Leader>Sn", function() vim.ui.input({ prompt = "Session name: " }, sessions.write) end, "New")
  C.nmap("<Leader>Sr", function() sessions.select("read") end, "Read")
  C.nmap("<Leader>SR", sessions.restart, "Restart")
  C.nmap("<Leader>Sw", sessions.write, "Write current")

  table.insert(C.keymap_groups, { "<Leader>S", group = "session" })
end)

C.now(function()
  local notify = require("mini.notify")
  notify.setup({
    lsp_progress = {
      duration_last = 0,
    },
  })
  keymap("n", "<Leader>sn", notify.show_history, { desc = "Notifications" })
end)
