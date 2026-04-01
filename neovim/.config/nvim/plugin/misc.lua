vim.pack.add({
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/christoomey/vim-tmux-navigator",
  "https://github.com/tpope/vim-sleuth",
  "https://github.com/airblade/vim-gitgutter",
})

vim.cmd.colorscheme("tokyonight-moon")

-- Highlight line numbers.
vim.g.gitgutter_highlight_linenrs = 1
