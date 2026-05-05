return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
  init_options = {
    hostInfo = "neovim",
    vue = {
      hybridMode = false,
    },
    typescript = {
      tsdk = "./node_modules/typescript/lib"
    },
  },
}
