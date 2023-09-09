local Util = require("lazyvim.util")

return {
  { "folke/flash.nvim", enabled = false }, -- disable search labels

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    module = "telescope",
    cmd = "Telescope",
    keys = {
      { "<C-t>", Util.telescope("files"), desc = "Find Files (root dir)" },
      { "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>sf", Util.telescope("files"), desc = "Find Files (root dir)" },
      { "<leader>sF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
      { "<leader>sp", "<cmd>Telescope oldfiles<cr>", desc = "Previous files" },
      { "<leader>sx", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      {
        "<leader>fb",
        function()
          require("telescope").extensions.file_browser.file_browser({ path = "%:h" })
        end,
        desc = "file browser"
      },

      -- unset Lazyvim keymaps
      { "<leader>sd", false }, -- search diagnostics (<leader>sx)
      { "<leader>ff", false }, -- find files (root) (<leader>sf)
      { "<leader>fF", false }, -- find files (cwd) (<leader>sF)
      { "<leader>fr", false }, -- recent files (<leader>sp)
    },
    opts = function(_, opts)
      local actions = require("telescope.actions")

      -- Scroll the preview window by a specified distance, rather than the default scroll_speed.
      local scroll_preview = function(bufnr, speed, direction)
        local status = require("telescope.state").get_status(bufnr)
        local default_speed = status.picker.layout_config.scroll_speed
        status.picker.layout_config.scroll_speed = speed
        require("telescope.actions.set").scroll_previewer(bufnr, direction)
        status.picker.layout_config.scroll_speed = default_speed
      end

      local actions_which_key = function(bufnr)
        actions.which_key(bufnr, { separator = "  " })
      end
      require("which-key").register({ ["<leader>s"] = { name = "+search" } })

      -- use telescope ivy theme
      opts.defaults = require("telescope.themes").get_ivy(opts.defaults)

      return vim.tbl_deep_extend("force", opts, {
        defaults = {
          path_display = { "smart" },
          results_title = false,
          scroll_strategy = "limit",
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-f>"] = actions.results_scrolling_down,
              ["<C-b>"] = actions.results_scrolling_up,

              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,

              ["<A-j>"] = function(bufnr)
                scroll_preview(bufnr, 1, 1)
              end,
              ["<A-k>"] = function(bufnr)
                scroll_preview(bufnr, 1, -1)
              end,
              ["<A-f>"] = actions.preview_scrolling_down,
              ["<A-b>"] = actions.preview_scrolling_up,

              ["<C-s>"] = actions.select_horizontal,
              ["<C-x>"] = require("trouble.providers.telescope").open_with_trouble,

              ["<C-o>"] = require("telescope.actions.layout").toggle_preview,

              ["<C-_>"] = actions_which_key, -- keys from pressing <C-/>
            },
            n = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-f>"] = actions.results_scrolling_down,
              ["<C-b>"] = actions.results_scrolling_up,

              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,

              ["<A-j>"] = function(bufnr)
                scroll_preview(bufnr, 1, 1)
              end,
              ["<A-k>"] = function(bufnr)
                scroll_preview(bufnr, 1, -1)
              end,
              ["<A-f>"] = actions.preview_scrolling_down,
              ["<A-b>"] = actions.preview_scrolling_up,

              ["<C-s>"] = actions.select_horizontal,
              ["<C-x>"] = require("trouble.providers.telescope").open_with_trouble,

              ["<C-c>"] = actions.close,
              ["<C-_>"] = actions_which_key, -- keys from pressing <C-/>
            },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_cursor({}),
          },
        },
      })
    end,
  },
  { "nvim-telescope/telescope-file-browser.nvim", lazy = true },

  {
    "folke/which-key.nvim",
    module = "which-key",
    opts = {
      icons = {
        separator = "",
      },
      window = {
        border = "single",
      },
    }
  },

  {
    "RRethy/vim-illuminate",
    keys = {
      { "<c-n>", function() require("illuminate").goto_next_reference(false) end, desc = "Next reference" },
      { "<c-p>", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev reference" },
      { "[[", false },
      { "]]", false },
    },
    opts = {
      filetypes_denylist = { "dirbuf", "dirvish", "fugitive", "tailscale" },
    },
    -- override config in LazyVim to prevent [[ and ]] keymaps
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },

  {
    "folke/todo-comments.nvim",
    dependencies = "plenary.nvim",
    opts = {
      highlight = {
        pattern = {
          [[.*<(KEYWORDS)\s*:]],
          [[.*<(KEYWORDS)\(.*\)\s*:]], -- handle KEYWORD(name):
        },
        keyword = "fg",
        after = "",
      },
      search = {
        pattern = [[\b(KEYWORDS)(\(.*\))?:]],
      },
    }
  },


  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Markdown preview" },
    },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  {
    "folke/trouble.nvim",
    opts = {
      cycle_results = false,
    },
  }
}
