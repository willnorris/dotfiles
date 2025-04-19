return {
  { import = "lazyvim.plugins.extras.util.mini-hipatterns" },

  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        tab_size = 0,
        show_buffer_icons = false,
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
      local snacks = require("snacks")
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
            { require("lazyvim.util.lualine").pretty_path() },
          },
          lualine_x = {},
          lualine_y = {
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = { fg = snacks.util.color("Constant") },
            },
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = { fg = snacks.util.color("Debug") },
            },
            "searchcount",
            { "selectioncount", fmt = function(str) return str:len() > 0 and "󰒉 " .. str end },
          },
          lualine_z = {
            { "location", padding = { left = 0, right = 1 } },
          },

        },
      })
    end,
  },

  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      -- use default dashboard header
      opts.dashboard.preset.header = nil
      local mod = require("util").mod
      return vim.tbl_deep_extend("force", opts, {
        input = {
          icon = "",
          win = {
            title_pos = "left",
            relative = "cursor",
            row = -3,
            col = 0,
            width = 30,
            keys = {
              ctrl_c = { "<C-c>", { "cmp_close", "cancel" }, mode = { "n", "i" } },
              esc = { "<Esc>", { "cmp_close", "cancel" }, mode = { "n", "i" } },
            },
          },
        },
        picker = {
          layout = {
            preset = "ivy",
          },
          win = {
            input = {
              keys = {
                ["<C-x>"] = { "trouble_open", mode = { "n", "i" }, },

                ["<C-c>"] = "close",

                ["<C-p>"] = { "history_back", mode = { "i", "n" } },
                ["<C-n>"] = { "history_forward", mode = { "i", "n" } },

                ["<C-f>"] = { "list_scroll_down", mode = { "i", "n" } },
                ["<C-b>"] = { "list_scroll_up", mode = { "i", "n" } },

                [mod("j")] = { "preview_down", mode = { "i", "n" } },
                [mod("k")] = { "preview_up", mode = { "i", "n" } },
                [mod("f")] = { "preview_scroll_down", mode = { "i", "n" } },
                [mod("b")] = { "preview_scroll_up", mode = { "i", "n" } },
              },
            },
            list = {
              keys = {
                ["<C-x>"] = "trouble_open",

                ["<C-f>"] = "list_scroll_down",
                ["<C-b>"] = "list_scroll_up",

                [mod("j")] = "preview_down",
                [mod("k")] = "preview_up",
                [mod("f")] = "preview_scroll_down",
                [mod("b")] = "preview_scroll_up",
              },
            },
          },
          actions = {
            preview_down = function(p)
              vim.api.nvim_win_call(p.preview.win.win, function() vim.cmd("normal! " .. Snacks.util.keycode("<C-e>")) end)
            end,
            preview_up = function(p)
              vim.api.nvim_win_call(p.preview.win.win, function() vim.cmd("normal! " .. Snacks.util.keycode("<C-y>")) end)
            end,
          },
        },
        zen = {
          toggles = {
            diagnostics = false,
            indent = false,
          },
          on_open = function()
            vim.opt.signcolumn = "no"
            vim.opt.number = false
          end,
        },
      })
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
      { "<Leader>uv", function() require("focus").focus_toggle() end, desc = "Toggle golden ratio view" }
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
      "kevinhwang91/promise-async",
    },
    config = true,
  },
}
