-- Heuristically set buffer options
C.now(function()
  vim.pack.add({ "https://github.com/tpope/vim-sleuth" })
end)

C.now_if_args(function()
  vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
  vim.lsp.enable({
    "lua_ls",
    "gopls",
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
    format_on_save = {},
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
  ai.setup({})
end)

C.later(function()
  local keymap = require("mini.keymap")
  keymap.setup()
  -- Press "jk" quickly to <esc>
  keymap.map_combo({ "i", "c", "x", "s" }, "jk", "<BS><BS><Esc>")
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
