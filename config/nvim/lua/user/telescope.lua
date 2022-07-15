local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

local actions = require "telescope.actions"

local defaults = {
  --prompt_prefix = "",
  --selection_caret = "",
  path_display = { "smart" },

  mappings = {
    i = {
      ["<C-n>"] = actions.cycle_history_next,
      ["<C-p>"] = actions.cycle_history_prev,

      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      ["<Down>"] = actions.move_selection_next,
      ["<Up>"] = actions.move_selection_previous,

      ["<C-c>"] = actions.close,

      ["<CR>"] = actions.select_default,
      ["<C-x>"] = actions.select_horizontal,
      ["<C-s>"] = actions.select_horizontal,
      ["<C-v>"] = actions.select_vertical,
      ["<C-t>"] = actions.select_tab,

      ["<A-k>"] = actions.preview_scrolling_up,
      ["<A-j>"] = actions.preview_scrolling_down,

      ["<PageUp>"] = actions.results_scrolling_up,
      ["<PageDown>"] = actions.results_scrolling_down,
      ["<C-b>"] = actions.results_scrolling_up,
      ["<C-f>"] = actions.results_scrolling_down,

      ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
      ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
      ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      ["<C-l>"] = actions.complete_tag,
      ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
    },

    n = {
      ["<C-n>"] = actions.cycle_history_next,
      ["<C-p>"] = actions.cycle_history_prev,

      ["j"] = actions.move_selection_next,
      ["k"] = actions.move_selection_previous,
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      ["<Down>"] = actions.move_selection_next,
      ["<Up>"] = actions.move_selection_previous,
      ["gg"] = actions.move_to_top,
      ["G"] = actions.move_to_bottom,

      ["<esc>"] = actions.close,
      ["<C-c>"] = actions.close,

      ["<CR>"] = actions.select_default,
      ["<C-x>"] = actions.select_horizontal,
      ["<C-s>"] = actions.select_horizontal,
      ["<C-v>"] = actions.select_vertical,
      ["<C-t>"] = actions.select_tab,

      ["<A-k>"] = actions.preview_scrolling_up,
      ["<A-j>"] = actions.preview_scrolling_down,

      ["<PageUp>"] = actions.results_scrolling_up,
      ["<PageDown>"] = actions.results_scrolling_down,
      ["<C-b>"] = actions.results_scrolling_up,
      ["<C-f>"] = actions.results_scrolling_down,

      ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
      ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
      ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

      ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      ["?"] = actions.which_key,
    },
  },
}
defaults = require 'telescope.themes'.get_ivy(defaults)

telescope.setup {
  defaults = defaults,
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  },
}
