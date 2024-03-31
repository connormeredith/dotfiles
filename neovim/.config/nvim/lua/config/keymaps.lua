vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
