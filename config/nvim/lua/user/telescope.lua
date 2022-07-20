local telescope = require "telescope"
local actions = require "telescope.actions"

-- Scroll the preview window by a specified distance, rather than the default scroll_speed.
local scroll_preview_custom = function(prompt_bufnr, speed, direction)
  local status = require("telescope.state").get_status(prompt_bufnr)
  local default_speed = status.picker.layout_config.scroll_speed
  status.picker.layout_config.scroll_speed = speed
  require("telescope.actions.set").scroll_previewer(prompt_bufnr, direction)
  status.picker.layout_config.scroll_speed = default_speed
end

local defaults = {
  path_display = { "smart" },
  results_title = false,
  color_devicons = false,

  mappings = {
    i = {
      ["<C-n>"] = actions.cycle_history_next,
      ["<C-p>"] = actions.cycle_history_prev,

      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      ["<Down>"] = actions.move_selection_next,
      ["<Up>"] = actions.move_selection_previous,

      ["<C-c>"] = actions.close,
      ["<C-o>"] = require("telescope.actions.layout").toggle_preview,

      ["<CR>"] = actions.select_default,
      ["<C-x>"] = actions.select_horizontal,
      ["<C-s>"] = actions.select_horizontal,
      ["<C-v>"] = actions.select_vertical,
      ["<C-t>"] = actions.select_tab,

      ["<A-j>"] = function(bufnr) scroll_preview_custom(bufnr, 1, 1) end,
      ["<A-k>"] = function(bufnr) scroll_preview_custom(bufnr, 1, -1) end,
      ["<A-f>"] = actions.preview_scrolling_down,
      ["<A-b>"] = actions.preview_scrolling_up,

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
      ["<C-o>"] = require("telescope.actions.layout").toggle_preview,

      ["<CR>"] = actions.select_default,
      ["<C-x>"] = actions.select_horizontal,
      ["<C-s>"] = actions.select_horizontal,
      ["<C-v>"] = actions.select_vertical,
      ["<C-t>"] = actions.select_tab,

      ["<A-j>"] = function(bufnr) scroll_preview_custom(bufnr, 1, 1) end,
      ["<A-k>"] = function(bufnr) scroll_preview_custom(bufnr, 1, -1) end,
      ["<A-f>"] = actions.preview_scrolling_down,
      ["<A-b>"] = actions.preview_scrolling_up,

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
    buffers = {
      ignore_current_buffer = true,
      sort_mru = true,
      previewer = false,
    }
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_cursor {
      }
    },
  },
}

telescope.load_extension("ui-select")
