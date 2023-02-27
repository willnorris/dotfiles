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
    opt = true,
    keys = "<leader>zz",
    dependencies = {
      "benstockil/twilight.nvim", -- dim inactive portions of file
    },
    config = function()
      require("zen-mode").setup({
        window = {
          options = {
            signcolumn = "no",
            number = false,
          },
        },
      })
      vim.keymap.set("n", "<leader>zz", "<Cmd>ZenMode<CR>", { desc = "zen mode" })
    end,
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

      return vim.tbl_deep_extend("keep", {
        header = [[
  ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
  ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
  ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
  ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
  ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
  ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
]],
      }, opts)
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
      presets = {
        command_palette = false,
        lsp_doc_border = true,
      },
    },
  },
}
