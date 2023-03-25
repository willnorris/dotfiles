return {
  { "lukas-reineke/indent-blankline.nvim", enabled = false },

  {
    "NvChad/nvim-colorizer.lua",
    event = "BufEnter",
    opts = {
      user_default_options = {
        names = false,
        tailwind = true,
        sass = { enable = true },
      },
    },
  },

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

  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "Open buffer 1" },
      { "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", desc = "Open buffer 2" },
      { "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", desc = "Open buffer 3" },
      { "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", desc = "Open buffer 4" },
      { "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", desc = "Open buffer 5" },
      { "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", desc = "Open buffer 6" },
      { "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", desc = "Open buffer 7" },
      { "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", desc = "Open buffer 8" },
      { "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", desc = "Open buffer 9" },
    },
    opts = {
      options = {
        tab_size = 0,
        show_buffer_close_icons = false,
        show_close_icon = false,
        always_show_bufferline = true,
        separator_style = { "", "" },
      },
      highlights = {
        buffer_selected = {
          italic = false
        },
      },
    },
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      local icons = require("lazyvim.config").icons
      return {
        options = {
          theme = "auto",
          section_separators = "",
          component_separators = "",
          disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(str)
                -- show first letter only
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
            { "filename", path = 1, symbols = { modified = " ", readonly = " ", unnamed = "" } },
            function()
              return require("nvim-treesitter").statusline({
                separator = "  ",
              })
            end,
          },
          lualine_x = { "encoding", "fileformat" },
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
    import = "lazyvim.plugins.extras.ui.mini-starter",
  },
  {
    "echasnovski/mini.starter",
    opts = {
      header = [[
    ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
    ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
    ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
    ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
    ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
    ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
]]
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
