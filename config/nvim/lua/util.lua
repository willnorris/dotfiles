local Job = require("plenary.job")

M = {}

-- mod returns a keybinding string with the appropriate modifier key and k.
-- It uses the modifier key that is two keys to the left of the space bar.
-- If tmux is active, in which case it uses <A-k>,
-- because tmux doesn't suppport the Super key and sends Alt instead.
-- On macOS, it uses <M-k> for the Option key.
-- On all other platforms, it uses <D-k> for the Super key.
M.mod = function(k)
  if os.getenv("TMUX") ~= nil then
    return "<A-" .. k .. ">"
  elseif vim.fn.has("mac") == 1 then
    return "<M-" .. k .. ">"
  else
    return "<D-" .. k .. ">"
  end
end

-- colorscheme returns the current system color scheme.
-- Return values are either "default", "dark", or "light".
M.colorscheme = function()
  local scheme
  Job:new({
    command = "gsettings",
    args = { "get", "org.gnome.desktop.interface", "color-scheme" },
    on_exit = function(j, code)
      if code == 0 then
        scheme = string.gsub(j:result()[1], "prefer%-", "")
      end
    end,
  }):sync()
  return scheme
end

return M
