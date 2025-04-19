M = {}

-- mod returns a keybinding string with the appropriate modifier key and k.
-- It uses the modifier key that is two keys to the left of the space bar.
-- On macOS, it uses <M-k> for the Option key.
-- On all other platforms, it uses <D-k> for the Super key.
-- Unless tmux is active, in which case it uses <A-k>,
-- because tmux doesn't suppport the Super key and sends Alt instead.
M.mod = function(k)
  if vim.fn.has("mac") == 1 then
    return "<M-" .. k .. ">"
  elseif os.getenv("TMUX") ~= nil then
    return "<A-" .. k .. ">"
  else
    return "<D-" .. k .. ">"
  end
end

return M
