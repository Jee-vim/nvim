local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  require("zedd.plugins.cmp.lazyspec"),
  require("zedd.plugins.colors.lazyspec"),
  require("zedd.plugins.comments.lazyspec"),
  require("zedd.plugins.oil.lazyspec"),
  require("zedd.plugins.gruvbox.lazyspec"),
  require("zedd.plugins.markdown.lazyspec"),
  require("zedd.plugins.telescope.lazyspec"),
  require("zedd.plugins.treesitter.lazyspec"),
  require("zedd.plugins.autopairs.lazyspec"),

  require("zedd.plugins.gitsigns.lazyspec"),
  require("zedd.plugins.gitconflict.lazyspec"),

  require("zedd.plugins.golf.lazyspec"),
  require("zedd.plugins.screenshot.lazyspec"),
  require("zedd.plugins.test.lazyspec"),
  require("zedd.plugins.screenkey.lazyspec"),
  require("zedd.plugins.kulala.lazyspec"),

  -- require("zedd.plugins.codeium.lazyspec"),
  -- require("zedd.plugins.brainrot.lazyspec"),
  -- require("zedd.plugins.cursor.lazyspec"),
  -- require("zedd.plugins.ollama.lazyspec"),
  -- require("zedd.plugins.indentmini.lazyspec"),
  -- require("zedd.plugins.hardtime.lazyspec"),
}

require("lazy").setup(plugins, {
  ui = {
    border = "none",
  },
})
