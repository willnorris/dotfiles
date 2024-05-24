return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed[#opts.ensure_installed + 1] = "go"

      return vim.tbl_deep_extend("force", opts, {
        auto_install = true,
        highlight = {
          enable = true,
          disable = function(_, bufnr)
            -- treesitter highlighting seems to have trouble with large files. Partially disussed
            -- (but not really resolved) at https://github.com/nvim-treesitter/nvim-treesitter/issues/556
            return vim.api.nvim_buf_line_count(bufnr) > 100000
          end,
        },
        incremental_selection = {
          enable = true,
          -- I don't love these default keymaps, but <c-space> from LazyVim conflicts with my tmux config
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })
    end,
  },
  { import = "lazyvim.plugins.extras.ui.treesitter-context" },
}
