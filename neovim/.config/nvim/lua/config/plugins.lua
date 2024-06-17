return {
  -- Seamless window navigation between nvim and tmux.
  "christoomey/vim-tmux-navigator",

  -- Detect tabstop and shiftwidth automatically.
  "tpope/vim-sleuth",

  -- Mappings for surrounding text.
  "tpope/vim-surround",

  -- Git integration.
  "tpope/vim-fugitive",

  -- Show git signs in signcolumn.
  "airblade/vim-gitgutter",

  { -- Colourscheme.
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight-moon")
    end,
  },

  { -- Rapid file navigation.
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup()

      vim.keymap.set("n", "<leader>a", function()
        harpoon:list():add()
      end)
      vim.keymap.set("n", "<leader>h", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set("n", "<leader>j", function()
        harpoon:list():select(1)
      end)
      vim.keymap.set("n", "<leader>k", function()
        harpoon:list():select(2)
      end)
      vim.keymap.set("n", "<leader>l", function()
        harpoon:list():select(3)
      end)
      vim.keymap.set("n", "<leader>;", function()
        harpoon:list():select(4)
      end)
    end,
  },

  { -- Fuzzyfinder.
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      require("telescope").setup({
        defaults = {
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
          },
        },
        pickers = {
          git_files = {
            show_untracked = true,
          },
          find_files = {
            hidden = true,
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

      local load_extension = require("telescope").load_extension
      load_extension("ui-select")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Search Git Files" })
      vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Search [B]uffers" })

      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch [W]ord" })
      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch Using [G]rep" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
      vim.keymap.set("n", "<leader>so", builtin.vim_options, { desc = "[S]each Vim [O]ptions" })

      vim.keymap.set("n", "<leader>.", builtin.resume, { desc = "Resume Previous Telescope Window" })
      vim.keymap.set("n", "<leader><Space>", builtin.builtin, { desc = "Search Telescope Builtins" })
      vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "Search Old Files" })
    end,
  },

  { -- Statusline.
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      sections = {
        lualine_a = {
          {
            -- Show filename in section a.
            "filename",
            -- Show relative path.
            path = 1,
          },
        },
      },
    },
  },

  { -- Treesitter.
    "nvim-treesitter/nvim-treesitter",
    -- dependencies = {
    --   "nvim-treesitter/nvim-treesitter-textobjects",
    -- },
    build = ":TSUpdate",
    opts = {
      -- List of language parsers to install.
      ensure_installed = {
        "bash",
        "css",
        "dockerfile",
        "html",
        "javascript",
        "json",
        "lua",
        "python",
        "tmux",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      -- Install parsers synchronously.
      sync_install = false,
      -- Automatically install missing parsers.
      auto_install = true,
      -- Enable syntax highlighting.
      highlight = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  { --LSP.
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Language server installation.
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Autocomplete support.
      "hrsh7th/cmp-nvim-lsp",

      { -- LSP progress notifications.
        "j-hui/fidget.nvim",
        opts = {},
      },

      { -- Configure LSP for Neovim config and plugin development.
        "folke/neodev.nvim",
        opts = {},
      },
    },
    config = function()
      -- Configure LSP keymaps and autocommands.
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
          end

          map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
          map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
          map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
          map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
          map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
          map("<F2>", vim.lsp.buf.rename, "Rename symbol")
          map("gl", vim.diagnostic.open_float, "Show diagnostic")

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- Disable tsserver formatting as it conflicts with prettier.
          if client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
          end

          -- Format on save.
          if client and client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = event.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = event.buf })
              end,
            })
          end

          -- Highlight references on hover.
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- Configure language servers.
      local language_servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                black = {
                  enabled = true,
                },
                mccabe = {
                  enabled = false,
                },
                pycodestyle = {
                  enabled = false,
                },
                pyflakes = {
                  enabled = false,
                },
                mypy = {
                  enabled = true,
                  dmypy = true,
                  report_progress = true,
                  live_mode = false,
                },
                pylint = {
                  enabled = true,
                },
                rope_completion = {
                  enabled = true,
                },
              },
            },
          },
        },
        tsserver = {},
        eslint = {},
      }

      require("mason").setup()

      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(language_servers),
        automatic_installation = { exclude = vim.tbl_keys(language_servers) },
        handlers = {
          function(server_name)
            local server = language_servers[server_name] or {}

            -- Override default server capabilities, if any.
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})

            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },

  { -- Linting and formatting.
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")

      local formatting = null_ls.builtins.formatting
      null_ls.setup({
        sources = {
          formatting.prettier.with({
            prefer_local = "node_modules/.bin",
          }),
          formatting.rustfmt,
          formatting.stylua,
        },
      })
    end,
  },

  { -- Autocompletion.
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      luasnip.config.setup({})

      cmp.setup({
        completion = { completeopt = "menu,menuone,noinsert" },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete({}),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
        },
      })
    end,
  },

  { -- DAP
    "mfussenegger/nvim-dap",
    dependencies = {
      { -- Debugger UI.
        "rcarriga/nvim-dap-ui",
        dependencies = {
          "nvim-neotest/nvim-nio",
        },
      },
    },
    config = function()
      local dap = require("dap")
      dap.set_log_level("INFO")

      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = dapui.open

      -- Keymaps.
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<S-F11>", dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set("n", "<S-F5>", dap.terminate, { desc = "Debug: Stop" })
      vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })

      require("dap.ext.vscode").load_launchjs(
        nil, -- Use the project's default .vscode/launch.json file.
        { node = { "javascript", "javascriptreact", "typescript", "typescriptreact" } }
      )

      dap.adapters.node = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
      }
      dap.adapters.python = {
        type = "server",
        port = "5678",
        host = "0.0.0.0",
        options = {
          source_filetype = "python",
        },
      }
    end,
  },
}
