return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'main',
  -- lazy = false (see upstream: nvim-treesitter does not support lazy-loading)
  config = function()
    require("zedd.plugins.treesitter.setup")
    require("zedd.plugins.treesitter.command")
  end,
}
