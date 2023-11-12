return {
  { "folke/flash.nvim", enabled = false }, -- disable search labels

  { "konfekt/vim-sentence-chopper" },      -- Semantic Line Breaks
  { "tpope/vim-sleuth" },                  -- Heuristically set buffer options

  {
    "max397574/better-escape.nvim",
    opts = {
      mapping = { "jk" },
    },
  },

  { -- Toggle, display, and navigate marks
    "chentoast/marks.nvim",
    keys = {
      { "<leader>um", "<cmd>MarksToggleSigns<cr>", desc = "Toggle marks" },
    },
    event = "VeryLazy",
    config = true,
  },


  { -- Telescope
    "nvim-telescope/telescope.nvim",
    module = "telescope",
    cmd = "Telescope",
    keys = {
      {
        "<leader>se",
        function() require("telescope").extensions.file_browser.file_browser({ path = "%:h" }) end,
        desc = "File explorer",
      },
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

      opts = vim.tbl_deep_extend("force", opts, {
        defaults = {
          path_display = { "smart" },
          results_title = false,
          scroll_strategy = "limit",
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_cursor({}),
          },
        },
      })

      local mappings = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-f>"] = actions.results_scrolling_down,
        ["<C-b>"] = actions.results_scrolling_up,

        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<M-j>"] = function(bufnr)
          scroll_preview(bufnr, 1, 1)
        end,
        ["<M-k>"] = function(bufnr)
          scroll_preview(bufnr, 1, -1)
        end,
        ["<M-f>"] = actions.preview_scrolling_down,
        ["<M-b>"] = actions.preview_scrolling_up,

        ["<C-s>"] = actions.select_horizontal,
        ["<C-x>"] = require("trouble.providers.telescope").open_with_trouble,

        ["<C-o>"] = require("telescope.actions.layout").toggle_preview,
        ["<C-c>"] = actions.close,
        ["<C-_>"] = actions_which_key, -- keys from pressing <C-/>
      }
      for k, v in pairs(mappings) do
        -- apply mappings to both normal and insert mode
        opts.defaults.mappings.i[k] = v
        opts.defaults.mappings.n[k] = v
      end

      return opts
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
    },
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
    },
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
  },

  { -- Copy text to clipboard with OSC52
    "ojroques/nvim-osc52",
    keys = {
      { "Y", function() require("osc52").copy_operator() end, expr = true, desc = "Yank to clipboard" },
      { "Y", function() require("osc52").copy_visual() end, mode = "v", desc = "Yank to clipboard" },
    },
    init = function()
      -- use osc52 as clipboard provider
      -- https://github.com/ojroques/nvim-osc52#using-nvim-osc52-as-clipboard-provider
      local function copy(lines, _)
        require("osc52").copy(table.concat(lines, "\n"))
      end

      local function paste()
        return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
      end

      vim.g.clipboard = {
        name = "osc52",
        copy = { ["+"] = copy, ["*"] = copy },
        paste = { ["+"] = paste, ["*"] = paste },
      }
    end,
    opts = { silent = true },
  },

  {
    "stevearc/qf_helper.nvim",
    opts = {
      quickfix = {
        default_bindings = false,
      },
    },
  },

  { -- Undo history visualizer
    "mbbill/undotree",
    keys = {
      { "<leader>uu", "<Cmd>UndotreeToggle<CR>", desc = "Toggle undo tree" },
    },
  },

  { import = "lazyvim.plugins.extras.editor.symbols-outline" },
}
