local cmp = require("cmp")
local luasnip = require("luasnip")

require("copilot_cmp").setup()
require("luasnip/loaders/from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<A-k>"] = cmp.mapping.scroll_docs(-2),
    ["<A-j>"] = cmp.mapping.scroll_docs(2),
    ["<C-c>"] = cmp.mapping.abort(),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-o>"] = cmp.mapping.complete(),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        nvim_lua = "[NVIM_LUA]",
        copilot = "[Copilot]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
        spell = "[Spell]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lsp" },
    { name = "copilot" },
    { name = "orgmode" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "spell" },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
})

-- LuaSnip keymaps to jump between snippet items
vim.keymap.set({ "i", "s" }, "<c-l>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<c-h>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end, { silent = true })
