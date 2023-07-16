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
  view = {
    side = "right",
  },
  git = {
    ignore = false,
  },
  filesystem_watchers = {
    ignore_dirs = {
      "node_modules",
    },
  },
})

vim.keymap.set("n", "<leader>ee", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<leader>ef", vim.cmd.NvimTreeFindFile)
