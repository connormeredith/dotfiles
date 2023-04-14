-- Line numbers.
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Files.
vim.opt.swapfile = false
vim.opt.backup = false

-- Colors.
vim.opt.termguicolors = true

-- Search.
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Wrapping.
vim.opt.wrap = false

-- Cursor.
vim.opt.cursorline = true

-- Editor.
vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"

-- Invisibles.
vim.opt.list = true
vim.opt.listchars:append "space:⋅"

-- Clipboard.
vim.opt.clipboard:append("unnamedplus")

