-- Don't use editorconfig.
vim.g.editorconfig = false

-- Decrease update time.
vim.opt.updatetime = 250

-- Configure splits.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Show line numbers.
vim.opt.number = true

-- Indenting and tabs.
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Enable 24-bit colour.
vim.opt.termguicolors = true

-- Don't highlight search matches.
vim.opt.hlsearch = false

-- Show search matches while typing.
vim.opt.incsearch = true

-- Ingore case when searching.
vim.opt.ignorecase = true

-- Override ignorecase if search contains a capital letter.
vim.opt.smartcase = true

-- Don't wrap lines.
vim.opt.wrap = false

-- Highlight cursor line.
vim.opt.cursorline = true

--Lines to keep above and below cursor.
vim.opt.scrolloff = 10

-- Always show the sign column.
vim.opt.signcolumn = "yes"

-- Customise whitespace characters.
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↵")

-- Auto-complete commands to longest string, then open menu.
vim.opt.wildmode = "longest,full"

-- Use the system clipboard.
vim.opt.clipboard:append("unnamedplus")
