vim.g.vsnip_snippet_dir = vim.fn.stdpath("config") .. "/snippets"
vim.g.vsnip_filetypes = {
  javascriptreact = {
    "javascript/react",
    "javascript/javascript",
    "javascript/js-ts",
    "tailwindcss",
    "html",
  },
  typescriptreact = {
    "javascript/react",
    "javascript/typescript",
    "javascript/js-ts",
    "tailwindcss",
    "html",
  },
  javascript = { "javascript/javascript", "javascript/js-ts" },
  typescript = { "javascript/typescript", "javascript/js-ts" },
  astro = { "javascript/jsx", "html" },
  vue = { "vue", "javascript/jsx", "html", "tailwindcss" },
  css = { "tailwindcss" },
  html = { "angular/html" },
  http = { "http" },
  c = { "c" },
  zig = { "zig" },
}
