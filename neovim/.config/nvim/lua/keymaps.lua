vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Reload config.
vim.keymap.set("n", "<leader>r", ":source $MYVIMRC<CR>")

-- Visual replace without yanking.
vim.keymap.set("v", "p", '"_dP')

-- Move lines up and down with J and K.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centred when scrolling up and down.
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Open file explorer.
vim.keymap.set("n", "<leader>e", ":Ex<CR>")

-- Close buffer.
vim.keymap.set("n", "<leader>x", ":bw<CR>")
vim.keymap.set("n", "<leader>X", ":bw!<CR>")

-- Copy python module path to system clipboard.
vim.keymap.set("n", "<leader>yp", function()
  local module_path = vim.fn.expand("%:r:gs?/?.?")
  vim.cmd("let @+='" .. module_path .. "'")
  vim.print(module_path)
end)
