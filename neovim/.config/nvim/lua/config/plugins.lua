return {
  { -- Run language servers in Docker containers for certain projects.
    "docker-lsp",
    opts = {},
    dev = true,
  },

  -- Seamless window navigation between nvim and tmux.
  "christoomey/vim-tmux-navigator",

  -- Detect tabstop and shiftwidth automatically.
  "tpope/vim-sleuth",

  -- Mappings for surrounding text.
  "tpope/vim-surround",

  { -- Show git signs in signcolumn.
    "airblade/vim-gitgutter",
    init = function()
      -- Highlight line numbers.
      vim.g.gitgutter_highlight_linenrs = 1
    end,
  },

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
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    opts = {
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
    },
    config = function(_, opts)
      require("telescope").setup(opts)

      -- Set vim.ui.select to use telescope.
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

  { -- Treesitter.
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      auto_install = true,
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
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",

      -- Autocomplete support.
      "hrsh7th/cmp-nvim-lsp",

      { -- Linting and formatting.
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "eslint",
          "lua_ls",
          "ts_ls",
        },
      })

      local null_ls = require("null-ls")
      local formatting = null_ls.builtins.formatting
      null_ls.setup({
        sources = {
          formatting.stylua,
        },
      })

      require("config.lsp").setup()
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
