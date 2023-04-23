vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  renderer = {
    add_trailing = true,
    highlight_git = true,
    icons = {
      show = {
        git = false,
      },
    },
  },
  git = {
    ignore = false,
  },
})
