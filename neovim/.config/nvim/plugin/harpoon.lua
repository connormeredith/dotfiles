vim.pack.add({
  { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
  "https://github.com/nvim-lua/plenary.nvim",
})

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
