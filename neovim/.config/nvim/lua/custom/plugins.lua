vim.cmd.packadd("packer.nvim")

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  use("bluz71/vim-nightfly-guicolors")

  use("christoomey/vim-tmux-navigator")

  use({
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons"
    }
  })

  use("tpope/vim-surround")

  use({
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup()
    end
  })

  use {
    "nvim-lualine/lualine.nvim",
    requires = {
      "nvim-tree/nvim-web-devicons"
    }
  }

  use({
	  "nvim-telescope/telescope.nvim",
    tag = '0.1.1',
	  requires = {
      "nvim-lua/plenary.nvim"
    }
  })

  use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

  use("tpope/vim-fugitive")

  use {
	  "VonHeikemen/lsp-zero.nvim",
	  branch = "v2.x",
	  requires = {
		  -- LSP support.
		  "neovim/nvim-lspconfig",
      {
        "williamboman/mason.nvim",
          run = function()
            pcall(vim.cmd, "MasonUpdate")
          end,
        },
		  "williamboman/mason-lspconfig.nvim",

		  -- Auto-completion.
		  "hrsh7th/nvim-cmp",
		  "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",

      -- Snippets.
		  {"L3MON4D3/LuaSnip"},
	  }
	}
end)
