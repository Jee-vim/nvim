return {
  cmd = { "astro-ls", "--stdio" },
  filetypes = { "astro", "typescript" },
  root_markers = {
    "astro.config.mjs",
    "package.json",
    ".git",
  },
  -- require to install typescript on project
  init_options = {
    typescript = {
      tsdk = "node_modules/typescript/lib",
    },
  }
}
