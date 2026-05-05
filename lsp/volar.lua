return {
  cmd = { "vue-language-server", "--stdio" },
  filetypes = { "vue" },
  init_options = {
    vue = {
      hybridMode = true,
    },
    typescript = {
      tsdk = "/run/current-system/sw/lib/node_modules/typescript/lib",
    },
  },
}
