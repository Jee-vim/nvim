require("nvim-treesitter").setup({})

-- Enable treesitter highlighting and indentation per buffer
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start, 0)
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- Install missing parsers only
local ensure_installed = {
  "comment",
  "markdown",
  "markdown_inline",
  "c",
  "lua",
  "javascript",
  "tsx",
  "typescript",
  "html",
  "json",
  "bash",
}

local already_installed = require("nvim-treesitter").get_installed()
local to_install = vim.iter(ensure_installed)
  :filter(function(p)
    return not vim.tbl_contains(already_installed, p)
  end)
  :totable()

if #to_install > 0 then
  require("nvim-treesitter").install(to_install)
end
