M = {}

-- mod returns a keybinding string with the appropriate modifier key and k.
-- It uses the modifier key that is two keys to the left of the space bar.
-- On macOS, it uses <M-k> for the Option key.
-- On all other platforms, it uses <D-k> for the Super key.
M.mod = function(k)
  local m = vim.fn.has("mac") == 1 and "M" or "D"
  return "<" .. m .. "-" .. k .. ">"
end

return M
