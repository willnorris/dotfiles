return {
  { "lukas-reineke/indent-blankline.nvim", enabled = false },

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
      input = {
        anchor = "NW",
        win_options = {
          winblend = 0,
        },
      },
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

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      return {
        options = {
          section_separators = "",
          component_separators = "",
        },
        sections = {
          lualine_a = {
            -- show first letter of mode only
            { "mode", fmt = function(str) return str:sub(1, 1) end },
          },
        },
      }
    end,
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
    "nvimdev/dashboard-nvim",
    opts = {
      config = {
        header = vim.split(string.rep("\n", 8) .. [[
███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
        ]] .. "\n\n", "\n"),
      },
    },
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
}
