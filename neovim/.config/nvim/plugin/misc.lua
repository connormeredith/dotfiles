vim.pack.add({
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/christoomey/vim-tmux-navigator",
  "https://github.com/tpope/vim-sleuth",
  "https://github.com/tpope/vim-surround",
  "https://github.com/airblade/vim-gitgutter",
  "https://github.com/github/copilot.vim",
})

vim.cmd.colorscheme("tokyonight-moon")

-- Highlight line numbers.
vim.g.gitgutter_highlight_linenrs = 1
