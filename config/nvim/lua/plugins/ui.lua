return {
  {
    "rcarriga/nvim-notify",
    keys = {
      { "<leader>un", false },
    },
  },

  { import = "lazyvim.plugins.extras.util.mini-hipatterns" },

  {
    "stevearc/dressing.nvim",
    module = "dressing",
    opts = {
      select = {
        telescope = require("telescope.themes").get_cursor(),
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        tab_size = 0,
        show_buffer_close_icons = false,
        show_close_icon = false,
        always_show_bufferline = true,
        separator_style = { "", "" },
        groups = {
          items = {
            require("bufferline.groups").builtin.pinned:with({ icon = "" })
          }
        },
      },
      highlights = {
        buffer_selected = {
          italic = false,
        },
      },
    },
  },

  { -- statusline
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local icons = require("lazyvim.config").icons
      local Util = require("lazyvim.util")
      return vim.tbl_deep_extend("force", opts, {
        options = {
          section_separators = "",
          component_separators = "",
        },
        sections = {
          lualine_a = {
            -- show first letter of mode only
            { "mode", fmt = function(str) return str:sub(1, 1) end },
          },
          lualine_b = {
            "branch",
            "diff",
          },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { Util.lualine.pretty_path() },
          },
          lualine_x = { "encoding", "fileformat" },
          lualine_y = {
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = Util.ui.fg("Constant"),
            },
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = Util.ui.fg("Debug"),
            },
            "searchcount",
            { "selectioncount", fmt = function(str) return str:len() > 0 and "󰒉 " .. str end },
          },
          lualine_z = {
            { "progress" },
            { "location", padding = { left = 0, right = 1 } },
          },

        },
      })
    end,
  },

  { -- Distraction-free writing and coding
    "folke/zen-mode.nvim",
    dependencies = {
      "benstockil/twilight.nvim", -- dim inactive portions of file
    },
    keys = {
      { "<leader>zz", "<Cmd>ZenMode<CR>", desc = "zen mode" },
    },
    opts = {
      window = {
        options = {
          signcolumn = "no",
          number = false,
        },
      },
      on_open = function()
        vim.b.miniindentscope_disable = true
      end,
      on_close = function()
        vim.b.miniindentscope_disable = false
      end,
    },
  },

  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      -- use default dashboard header
      opts.dashboard.preset.header = nil
      return opts
    end,
  },

  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        view = "cmdline",
        format = {
          cmdline = { icon = ":" },
        },
      },
      messages = {
        view_search = false,
      },
      presets = {
        command_palette = false,
        lsp_doc_border = true,
      },
    },
  },

  { -- Auto-resize windows according to golden ratio
    "nvim-focus/focus.nvim",
    branch = "refactor",
    event = "VimEnter",
    keys = {
      { "<leader>uv", function() require("focus").focus_toggle() end, desc = "Toggle golden ratio view" }
    },
    opts = {
      ui = {
        signcolumn = false,
      },
    },
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async", -- dim inactive portions of file
    },
    config = true,
  },
}
