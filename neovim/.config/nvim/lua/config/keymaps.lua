vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Move lines up and down.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Show file explorer.
vim.keymap.set("n", "<leader>e", ":Ex<CR>")

-- Wipe buffer.
vim.keymap.set("n", "<leader>x", ":bw<CR>")
