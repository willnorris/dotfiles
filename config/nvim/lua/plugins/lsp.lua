-- LSP
return {
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.go" },
  { import = "lazyvim.plugins.extras.lang.tailwind" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- setup handlers
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] =
          vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Enable virtual text only on Warning or above
        virtual_text = {
          severity = { min = vim.diagnostic.severity.WARN },
        },
      })

      -- use telescope LSP handlers
      local tb = require("telescope.builtin")
      vim.lsp.handlers["callHierarchy/incomingCalls"] = tb.lsp_incoming_calls
      vim.lsp.handlers["callHierarchy/outgoingCalls"] = tb.lsp_outgoing_calls
      vim.lsp.handlers["textDocument/references"] = tb.lsp_references
      vim.lsp.handlers["textDocument/typeDefinition"] = tb.lsp_type_definitions
      vim.lsp.handlers["textDocument/implementation"] = tb.lsp_implementations
      vim.lsp.handlers["textDocument/documentSymbol"] = tb.lsp_document_symbols
      vim.lsp.handlers["workspace/symbol"] = tb.lsp_workspace_symbols
      -- causes issues with goto-preview
      --vim.lsp.handlers["textDocument/definition"] = tb.lsp_definitions

      -- override some keymaps from LazyVim
      local keymaps = require("lazyvim.plugins.lsp.keymaps")
      local keys = keymaps.get()
      --keys[#keys + 1] = { "gd", vim.lsp.buf.definition, desc = "Goto Definition" }
      keys[#keys + 1] = { "gn", vim.lsp.buf.incoming_calls, desc = "Incoming Calls" }
      keys[#keys + 1] = { "gi", vim.lsp.buf.implementation, desc = "Goto Implementation" }
      keys[#keys + 1] = { "gt", vim.lsp.buf.type_definition, desc = "Goto Type Definition" }
      keys[#keys + 1] = { "gl", vim.lsp.codelens.run, desc = "Run codelens" }
      keys[#keys + 1] = { "gk", vim.lsp.buf.signature_help, desc = "Signature Help" }

      -- workspace folders
      require("which-key").register({ ["<leader>w"] = { name = "+workspace" } })
      keys[#keys + 1] = { "<leader>wa", vim.lsp.buf.add_workspace_folder, desc = "add workspace folder" }
      keys[#keys + 1] = { "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "remove workspace folder" }
      keys[#keys + 1] = {
        "<leader>wl",
        function()
          vim.notify(
            vim.pretty_print(vim.lsp.buf.list_workspace_folders()),
            vim.log.levels.INFO,
            { title = "LSP Workspace folders" }
          )
        end,
        desc = "list workspace folders",
      }

      require("lspconfig.ui.windows").default_options.border = "rounded"
    end,
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = {
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                  [vim.fn.stdpath("config") .. "/lua"] = true,
                },
              },
            },
          },
        },
        gopls = {
          settings = {
            gopls = {
              gofumpt = false,
            },
          },
        },
        sourcekit = {
          cmd = { "xcrun", "sourcekit-lsp" },
          filetypes = { "swift" },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    opts = {
      cmd = { vim.fn.stdpath("data") .. "/mason/bin/jdtls" },
      root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
    },
    config = function(_, opts)
      require("jdtls").start_or_attach(opts)
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "",
          package_pending = "",
          package_uninstalled = ""
        }
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          nls.builtins.code_actions.gitsigns,
          nls.builtins.code_actions.shellcheck,
          nls.builtins.diagnostics.shellcheck,
        },
      }
    end,
  },
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.linting.eslint" },
  {
    -- Display LSP results in preview window
    "rmagatti/goto-preview",
    event = "VeryLazy",
    opts = {
      border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
      default_mappings = true,
      resizing_mappings = true,
      post_open_hook = function(_, winid)
        vim.keymap.set("n", "q", function() vim.api.nvim_win_close(winid, false) end)
      end
    },
  },
  {
    "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
    keys = {
      { "<leader>ux", "<Plug>(toggle-lsp-diag-vtext)", desc = "Toggle LSP virtual text" },
    },
    config = function()
      require("toggle_lsp_diagnostics").init()
    end,
  },
  {
    -- File outline based on LSP symbols
    "simrat39/symbols-outline.nvim",
    keys = {
      { "<leader>o", "<Cmd>SymbolsOutline<CR>", desc = "symbol outline" },
    },
    opts = {
      auto_preview = false,
    },
  },
}
