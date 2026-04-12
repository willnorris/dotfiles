-- C global config table to pass data between scripts.
_G.C = {}

-- Load mini.nvim now to have 'mini.misc' available for custom loading helpers.
vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

-- Loading helpers used to organize config into fail-safe parts.
-- See `:h MiniMisc.safely` for details.
local misc = require('mini.misc')
C.now = function(f) misc.safely('now', f) end
C.later = function(f) misc.safely('later', f) end
C.now_if_args = vim.fn.argc(-1) > 0 and C.now or C.later
C.on_event = function(ev, f) misc.safely('event:' .. ev, f) end
C.on_filetype = function(ft, f) misc.safely('filetype:' .. ft, f) end

-- Custom autocommand group and helper for creating autocommands.
local gr = vim.api.nvim_create_augroup('custom-config', {})
C.autocmd = function(event, pattern, callback, desc)
  local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end

-- Custom `vim.pack.add()` hook helper.
C.on_packchanged = function(plugin_name, kinds, callback, desc)
  local f = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then return end
    if not ev.data.active then vim.cmd.packadd(plugin_name) end
    callback(ev.data)
  end
  C.autocmd('PackChanged', '*', f, desc)
end
