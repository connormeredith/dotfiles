vim.g.mapleader = " "

-- Toggle nvim-tree.
vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle)

-- Move lines up and down.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
