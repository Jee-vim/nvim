return {
  "nvzone/showkeys",
  cmd = "ShowkeysToggle",
  config = function()
    require("zedd.plugins.screenkey.setup")
    vim.cmd("ShowkeysToggle")
  end,
}
