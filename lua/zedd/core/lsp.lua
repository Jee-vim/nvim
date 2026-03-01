vim.lsp.enable({
  "ts_ls",
  "astro",
  "lua_ls",
  "css_ls",
  "nixd_ls",
  "zls",
})
vim.lsp.config("*", {
  root_markers = { ".git", "package.json", "tsconfig.json" },
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      },
    },
  },
})
vim.diagnostic.config({
  virtual_lines = false,
  virtual_text = false,
  underline = { severity = { min = vim.diagnostic.severity.ERROR } },
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded", -- "single", "double", "shadow", etc.
    source = "always",  -- "always", "never"
    header = "",
    prefix = "",
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.nix", "*.zig", "*.ts", "*.tsx", "*.astro", "*.css", "*.lua" },
  callback = function()
    vim.lsp.buf.format({ async = true })
  end,
})
