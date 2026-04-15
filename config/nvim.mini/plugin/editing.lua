-- Heuristically set buffer options
C.now(function()
  vim.pack.add({ "https://github.com/tpope/vim-sleuth" })
end)

C.now_if_args(function()
  vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
  vim.lsp.enable({
    "basedpyright",
    "gopls",
    "lua_ls",
    "rust_analyzer",
    "vtsls",
  })
end)

C.later(function()
  vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
  local conform = require("conform")
  conform.setup({
    default_format_opts = {
      -- Allow formatting from LSP server if no dedicated formatter is available
      lsp_format = "fallback",
    },
    format_on_save = function(bufnr)
      if vim.b[bufnr].autoformat ~= nil then
        return vim.b[bufnr].autoformat and {} or nil
      end
      if vim.g.autoformat ~= nil then
        return vim.g.autoformat and {} or nil
      end
      return {}
    end,
    -- Map of filetype to formatters
    -- Make sure that necessary CLI tool is available
    formatters_by_ft = {
      go = { "goimports", "gofmt" },
    },
  })
  vim.keymap.set({ "n", "x" }, "<Leader>cf",
    function() conform.format() end,
    { desc = "Format" })
  vim.keymap.set({ "n", "x" }, "<leader>cF",
    function() conform.format({ formatters = { "injected" }, timeout_ms = 3000 }) end,
    { desc = "Format Injected Langs" }
  )
end)

C.now_if_args(function()
  -- Define hook to update tree-sitter parsers after plugin is updated
  local ts_update = function() vim.cmd("TSUpdate") end
  C.on_packchanged("nvim-treesitter", { "update" }, ts_update, ":TSUpdate")

  vim.pack.add({
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
    "https://github.com/nvim-treesitter/nvim-treesitter-context",
  })

  require("nvim-treesitter-textobjects").setup()
  require("treesitter-context").setup()

  vim.keymap.set("n", "[c", function()
    require("treesitter-context").go_to_context(vim.v.count1)
  end, { silent = true })

  -- Languages to install and auto enable. After changing, restart and wait for install.
  -- To see available languages:
  --  - execute `:=require('nvim-treesitter').get_available()`
  --  - visit https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
  local languages = {
    "lua",
    "vimdoc",
    "markdown",
    "go", "gomod", "gosum", "gowork",
  }
  local to_install = vim.tbl_filter(function(lang)
    return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
  end, languages)
  if #to_install > 0 then require("nvim-treesitter").install(to_install) end

  -- Enable tree-sitter after opening a file for a target language
  local filetypes = {}
  for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
      table.insert(filetypes, ft)
    end
  end
  local ts_start = function(ev) vim.treesitter.start(ev.buf) end
  C.autocmd("FileType", filetypes, ts_start, "Start tree-sitter")
end)

C.now_if_args(function()
  local cmp = require("mini.completion")
  -- Don't show 'Text' suggestions (usually noisy) and show snippets last.
  local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
  local process_items = function(items, base)
    return cmp.default_process_items(items, base, process_items_opts)
  end
  cmp.setup({
    lsp_completion = {
      source_func = "omnifunc",
      auto_setup = false,
      process_items = process_items,
    },
  })

  -- Set 'omnifunc' for LSP completion only when needed.
  local on_attach = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
  end
  C.autocmd("LspAttach", nil, on_attach, "Set 'omnifunc'")

  -- Advertise to servers that Neovim now supports certain set of completion and
  -- signature features through 'mini.completion'.
  vim.lsp.config("*", { capabilities = cmp.get_lsp_capabilities() })

  C.autocmd("FileType", "snacks_picker_input",
    function(args) vim.b[args.buf].minicompletion_disable = true end,
    "Disable completion in snacks picker")
end)

C.later(function()
  vim.pack.add({ "https://github.com/folke/trouble.nvim" })
  local trouble = require("trouble")
  trouble.setup({
    cycles_results = false
  })

  C.nmap("<Leader>xx", "<cmd>Trouble diagnostics toggle<cr>", "Diagnostics (Trouble)")
  C.nmap("<Leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer Diagnostics (Trouble)")
  C.nmap("<Leader>cs", "<cmd>Trouble symbols toggle<cr>", "Symbols (Trouble)")
  C.nmap("<Leader>cS", "<cmd>Trouble lsp toggle<cr>", "LSP references/definitions/... (Trouble)")
  C.nmap("<Leader>xL", "<cmd>Trouble loclist toggle<cr>", "Location List (Trouble)")
  C.nmap("<Leader>xQ", "<cmd>Trouble qflist toggle<cr>", "Quickfix List (Trouble)")
  C.nmap("[q", function()
    if trouble.is_open() then
      trouble.prev({ skip_groups = true, jump = true })
    else
      local ok, err = pcall(vim.cmd.cprev)
      if not ok then
        vim.notify(err, vim.log.levels.ERROR)
      end
    end
  end, "Previous Trouble/Quickfix Item")
  C.nmap("]q", function()
    if trouble.is_open() then
      trouble.next({ skip_groups = true, jump = true })
    else
      local ok, err = pcall(vim.cmd.cnext)
      if not ok then
        vim.notify(err, vim.log.levels.ERROR)
      end
    end
  end, "Next Trouble/Quickfix Item")
end)

-- Semantic Line Breaks
C.later(function()
  vim.pack.add({ "https://github.com/konfekt/vim-sentence-chopper" })
  vim.keymap.set({ "n", "x" }, "gs", "<Plug>(ChopSentences)",
    { desc = "Semantic Line Break" })
end)

C.later(function()
  vim.pack.add({ "https://github.com/chentoast/marks.nvim" })
  require("marks").setup()
  C.nmap("<Leader>um", "<Cmd>MarksToggleSigns<CR>", "Toggle marks")
end)

C.later(function()
  require("mini.surround").setup({
    mappings = {
      add = "ys",     -- Add surrounding in Normal and Visual modes
      delete = "ds",  -- Delete surrounding
      replace = "cs", -- Replace surrounding
    },
  })
end)

C.later(function()
  local ai = require("mini.ai")
  ai.setup({
    n_lines = 500,
    custom_textobjects = {
      o = ai.gen_spec.treesitter({ -- code block
        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
      }),
      f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
      c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),       -- class
      t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },           -- tags
      d = { "%f[%d]%d+" },                                                          -- digits
      e = {                                                                         -- Word with case
        { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
        "^().*()$",
      },
      u = ai.gen_spec.function_call(),                           -- u for "Usage"
      U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
    },
  })
end)

C.later(function()
  local bracketed = require("mini.bracketed")
  bracketed.setup({
    file = { suffix = "" },
  })

  vim.keymap.set({ "n", "x", "o" }, "]f", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
  end, { desc = "Function backward" })
  vim.keymap.set({ "n", "x", "o" }, "[f", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
  end, { desc = "Function forward" })
end)

C.later(function()
  local mk = require("mini.keymap")
  mk.setup()

  -- Press "jk" quickly to <esc>
  mk.map_combo({ "i", "c", "x", "s" }, "jk", "<BS><BS><Esc>")

  -- ctrl+j/k to navigate menus
  mk.map_multistep({ "i", "c" }, "<C-j>", { "pmenu_next" })
  mk.map_multistep({ "i", "c" }, "<C-k>", { "pmenu_prev" })

  mk.map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
  mk.map_multistep("i", "<BS>", { "minipairs_bs" })

  mk.map_multistep("i", "<Tab>",
    { "minisnippets_next", "minisnippets_expand", "pmenu_next" })
  mk.map_multistep("i", "<S-Tab>",
    { "minisnippets_prev", "pmenu_prev" })
end)

C.later(function()
  vim.pack.add({ "https://github.com/rmagatti/goto-preview" })
  local gp = require("goto-preview")
  gp.setup({
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    default_mappings = true,
    resizing_mappings = true,
    post_open_hook = function(_, winid)
      vim.keymap.set("n", "q", function()
        vim.api.nvim_win_close(winid, false)
      end)
    end,
  })
  -- use 'y' in addition to 't' for type definition to match LSP mappings
  --{ "gpy", function() require("goto-preview").goto_preview_type_definition() end, desc = "Preview type definition" }
  C.nmap("gpy", gp.goto_preview_type_definition, "Preview type defintion")
end)

-- Restore 'gw' to default behavior by resetting formatexpr if null-ls
-- is not providing any formatting generators.
-- See: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131
C.later(function()
  vim.pack.add({
    "https://github.com/folke/snacks.nvim",
    "https://github.com/nvimtools/none-ls.nvim",
  })
  require("snacks.util").lsp.on({ name = "none-ls" }, function(buf)
    if not require("none-ls.generators").can_run(vim.bo[buf].filetype, require("none-ls.methods").lsp.FORMATTING) then
      vim.bo[buf].formatexpr = nil
    end
  end)
end)

C.later(function()
  vim.pack.add({ "https://github.com/zk-org/zk-nvim" })
  require("zk").setup({
    picker = "snacks_picker",
    lsp = {
      config = {
        name = "zk",
        cmd = { "zk", "lsp" },
        filetypes = { "markdown" },
      },
      auto_attach = {
        enabled = true,
      },
    },
  })
end)
