return {
  { "folke/flash.nvim", enabled = false }, -- disable search labels

  {
    "konfekt/vim-sentence-chopper", -- Semantic Line Breaks
    keys = {
      { "gs", "<plug>(ChopSentences)", mode = { "n", "x" }, desc = "Semantic Line Break" },
    },
  },
  { "tpope/vim-sleuth" }, -- Heuristically set buffer options

  {
    "max397574/better-escape.nvim",
    opts = {
      mappings = {
        -- disable "jj" mappings
        i = { j = { j = false } },
        c = { j = { j = false } },
        t = { j = { j = false } },
      },
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
      {
        "<leader>sx",
        function() require("telescope.builtin").resume() end,
        noremap = true,
        silent = true,
        desc = "Resume telescope",
      },
      {
        "<leader>gl", -- "gl" for "git log"
        function() require("telescope").extensions.git_file_history.git_file_history() end,
        desc = "Git file history",
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

      -- use telescope ivy theme
      opts.defaults = require("telescope.themes").get_ivy(opts.defaults)

      opts = vim.tbl_deep_extend("force", opts, {
        defaults = {
          layout_config = {
            height = 40,
          },
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

      local mod = require("util").mod

      local mappings = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-f>"] = actions.results_scrolling_down,
        ["<C-b>"] = actions.results_scrolling_up,

        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        [mod("j")] = function(bufnr)
          scroll_preview(bufnr, 1, 1)
        end,
        [mod("k")] = function(bufnr)
          scroll_preview(bufnr, 1, -1)
        end,
        [mod("f")] = actions.preview_scrolling_down,
        [mod("b")] = actions.preview_scrolling_up,

        ["<C-s>"] = actions.select_horizontal,
        ["<C-x>"] = require("trouble.sources.telescope").open,

        ["<C-o>"] = require("telescope.actions.layout").toggle_preview,
        ["<C-c>"] = actions.close,
        ["<C-_>"] = actions_which_key, -- keys from pressing <C-/>

        ["<C-d>"] = actions.delete_buffer,
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
    "isak102/telescope-git-file-history.nvim",
    dependencies = { "tpope/vim-fugitive" },
    lazy = true
  },

  {
    "folke/which-key.nvim",
    module = "which-key",
    opts = {
      icons = {
        separator = "",
        rules = false,
      },
      win = {
        border = "single",
      },
    },
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
}
