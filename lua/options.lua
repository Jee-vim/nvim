vim.o.nu = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.wrap = false
vim.o.smartindent = true
vim.o.inccommand = "split"

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.laststatus = 3

vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath("data") .. "/undodir"

vim.opt.clipboard:append("unnamedplus")
vim.opt.isfname:append("@-@")
vim.o.guicursor = ""
vim.o.scrolloff = 8

vim.o.signcolumn = "yes"
vim.o.cmdheight = 0
vim.o.termguicolors = true
