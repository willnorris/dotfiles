C.later(function()
  vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
  vim.lsp.enable({
    "lua_ls",
  })
end)

C.later(function()
  vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })
  local conform = require('conform')
  conform.setup({
    default_format_opts = {
      -- Allow formatting from LSP server if no dedicated formatter is available
      lsp_format = 'fallback',
    },
    -- Map of filetype to formatters
    -- Make sure that necessary CLI tool is available
    -- formatters_by_ft = { lua = { 'stylua' } },
  })
  vim.keymap.set({ 'n', 'x' }, '<Leader>cf',
    function() conform.format() end,
    { desc = 'Format' })
  vim.keymap.set({ 'n', 'x' }, "<leader>cF",
    function() conform.format({ formatters = { "injected" }, timeout_ms = 3000 }) end,
    { desc = "Format Injected Langs" }
  )
end)

C.now_if_args(function()
  -- Define hook to update tree-sitter parsers after plugin is updated
  local ts_update = function() vim.cmd('TSUpdate') end
  C.on_packchanged('nvim-treesitter', { 'update' }, ts_update, ':TSUpdate')

  vim.pack.add({
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  })

  -- Languages to install and auto enable. After changing, restart and wait for install.
  -- To see available languages:
  --  - execute `:=require('nvim-treesitter').get_available()`
  --  - visit https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
  local languages = {
    'lua',
    'vimdoc',
    'markdown',
  }
  local to_install = vim.tbl_filter(function(lang)
    return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
  end, languages)
  if #to_install > 0 then require('nvim-treesitter').install(to_install) end

  -- Enable tree-sitter after opening a file for a target language
  local filetypes = {}
  for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
      table.insert(filetypes, ft)
    end
  end
  local ts_start = function(ev) vim.treesitter.start(ev.buf) end
  C.autocmd('FileType', filetypes, ts_start, 'Start tree-sitter')
end)
