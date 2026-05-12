local command = vim.api.nvim_create_user_command

command("TSPrintNode", function()
  local node = vim.treesitter.get_node()
  if node then
    vim.notify(node:type())
  end
end, { nargs = 0 })
