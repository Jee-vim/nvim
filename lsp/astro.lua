return {
  cmd = { "astro-ls", "--stdio" },
  filetypes = { "astro", "typescript" },
  root_markers = {
    "astro.config.mjs",
    "package.json",
    ".git",
  },
  init_options = {
    typescript = {
      tsdk = "/run/current-system/sw/lib/node_modules/typescript/lib",
    },
  }
}
