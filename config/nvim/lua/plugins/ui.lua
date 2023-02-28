return {
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  { "bufferline.nvim",                     enabled = false },

  {
    "stevearc/dressing.nvim",
    module = "dressing",
    opts = {
      input = {
        anchor = "NW",
        win_options = {
          winblend = 0,
        },
      },
      select = {
        telescope = require("telescope.themes").get_cursor(),
      },
    }
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      local icons = require("lazyvim.config").icons
      return {
        options = {
          theme = "auto",
          --icons_enabled = false,
          section_separators = "",
          component_separators = "",
          disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(str)
                return str:sub(1, 1)
              end,
            },
          },
          lualine_b = {
            "branch",
            "diff",
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
          },
          lualine_c = {
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
            --{ "filename", color = { fg = "white" } },
            function()
              return require("nvim-treesitter").statusline({
                separator = "  ",
              })
            end,
          },
          lualine_x = {'encoding', 'fileformat'},
        },
        tabline = {
          lualine_a = { { "buffers", mode = 0 } },
          lualine_z = { { "tabs", mode = 0 } },
        },
      }
    end
  },

  -- Distraction-free writing and coding
  {
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
    "LazyVim/LazyVim",
    import = "lazyvim.plugins.extras.ui.mini-starter",
  },
  {
    "echasnovski/mini.starter",
    opts = function (_, opts)
      local pad = string.rep(" ", 22)
      opts.items[#opts.items + 1] = { name = "Session", action = [[lua require("persistence").load()]], section = pad .. "Session" }

      return vim.tbl_deep_extend("force", opts, {
        header = [[
  ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
  ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
  ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
  ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
  ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
  ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
]],
      })
    end
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
        --view = "mini",
        view_search = false,
      },
      presets = {
        command_palette = false,
        lsp_doc_border = true,
      },
    },
  },
}
