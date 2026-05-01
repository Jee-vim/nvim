return {
  cmd = { "vue-language-server", "--stdio" },
  filetypes = { "vue" },
  init_options = {
    hostInfo = "neovim",
    typescript = {
      tsdk = "./node_modules/typescript/lib"
    },
  },
  on_new_config = function(new_config, new_root_dir)
    -- Resolve tsdk relative to project root
    if new_root_dir then
      local tsdk = new_root_dir .. "/node_modules/typescript/lib"
      new_config.init_options.typescript.tsdk = tsdk
    end
  end,
}
