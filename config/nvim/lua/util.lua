M = {}

-- mod returns a keybinding string with the appropriate modifier key and k.
-- It uses the modifier key that is two keys to the left of the space bar.
M.mod = function(k)
  -- tmux doesn't support Super key and sends Alt instead
  if vim.env.TMUX ~= nil then
    return "<A-" .. k .. ">"
  end

  -- with ghostty terminal, I map commonly used Super+k keys to Alt+k
  -- for consistent behavior with and without tmux.
  if vim.env.TERM_PROGRAM == "ghostty" then
    return "<A-" .. k .. ">"
  end

  -- on macOS, use <M-k> for the Option key
  if vim.fn.has("mac") == 1 then
    return "<M-" .. k .. ">"
  end

  -- on all other platforms, use <D-k> for the Super key
  return "<D-" .. k .. ">"
end

return M
