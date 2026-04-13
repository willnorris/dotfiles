-- Lua LSP config, optimized for editing Neovim config
-- Requires https://github.com/LuaLS/lua-language-server
-- (mise use -g aqua:LuaLS/lua-language-server)
return {
  on_attach = function(client, buf_id)
    -- Reduce very long list of triggers for better 'mini.completion' experience
    client.server_capabilities.completionProvider.triggerCharacters =
    { ".", ":", "#", "(" }
  end,

  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
          path ~= vim.fn.stdpath("config")
          and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = {
        version = "LuaJIT",
        -- Find Lua modules same way as Neovim (see `:h lua-module-load`)
        path = {
          "lua/?.lua",
          "lua/?/init.lua",
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        ignoreSubmodules = true,
        checkThirdParty = false,
        -- load vim runtime, and optionally all plugins
        library = (function()
          local rtf = { vim.env.VIMRUNTIME }
          if false then -- set true to include all plugins (very slow)
            for _, v in ipairs(vim.api.nvim_get_runtime_file("", true)) do
              -- skip local config files to prevent [duplicate-doc-field] warnings
              if v ~= vim.fn.stdpath("config") and v ~= vim.fn.stdpath("config") .. "/after" then
                table.insert(rtf, v)
              end
            end
          end
          return rtf
        end)()
      },
    })
  end,
  settings = {
    Lua = {},
  },
}
