vim.o.nu = true
vim.o.relativenumber = true

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.backspace = "start,eol,indent"

vim.o.wrap = false
vim.o.smartindent = true
vim.o.inccommand = "split"

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.laststatus = 3

vim.opt.mouse = "a"
vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.o.list = true
vim.o.foldtext = "v:lua.fold_text()"
vim.o.foldlevelstart = 99

vim.opt.fillchars:append({
  eob = " ",
})
vim.opt.listchars = {
  tab = "  ",
  space = " ",
}

vim.opt.clipboard:append("unnamedplus")
vim.opt.isfname:append("@-@")
vim.o.guicursor = ""
vim.o.scrolloff = 8

vim.o.signcolumn = "yes"
vim.o.cmdheight = 0
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.winblend = 5
vim.o.wildoptions = "pum"
vim.o.pumblend = 5
vim.o.background = "dark"

function fold_text()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_text = string.gsub(line, '^"{\\+', "")
  return line_text
end
